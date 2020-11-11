//
//  ConversationsListViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 27.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import os.log
import Firebase

final class ConversationsListViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var avatarView: MiniAvatarView!
  @IBOutlet private weak var settingsIcon: UIBarButtonItem!
  private var searchController = UISearchController(searchResultsController: nil)
  
  //let dataManager: Storeable = OperationDataManager.shared
  let dataManager: Storeable = GCDDataManager.shared
  
  private var channels = [Channel]()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupSearchController()
    loadChannels()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupMiniature()
    updateTheme()
  }
  
  // MARK: - Private methods
  private func loadChannels() {
    FirebaseManager.shared.getChannels { (result) in
      switch result {
      case .failure( _): break
      case .success(let channels):
        self.channels = channels.sorted {
          $0.lastActivity ?? Date() > $1.lastActivity ?? Date()
        }
        self.tableView.reloadData()
      }
    }
  }
  
  private func updateTheme() {
    ThemeManager.shared.applyTheme()
    self.view.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    self.tableView.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    self.navigationController?.navigationBar.barStyle = ThemeManager.shared.barStyle
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.mainTextColor]
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.shared.current.mainTextColor]
    settingsIcon.tintColor = ThemeManager.shared.current.tintColor
  }
  
  // MARK: - @IBActions
  @IBAction func addChannelButtonTapped(_ sender: Any) {
    showChannelAlert()
  }
  
  @IBAction func settingsTapped(_ sender: UIBarButtonItem) {
    let themesVC: ThemesViewController = ThemesViewController.loadFromStoryboard()
    // MARK: Delegate
    // themesVC.delegate = self
    
    // MARK: Closure
    themesVC.didChangeTheme = { [weak self] in
      self?.updateTheme()
    }
    self.navigationController?.pushViewController(themesVC, animated: true)
  }
    
  deinit {
    os_log("%@", log: .retainCycle, type: .info, self)
  }
}

// MARK: ThemesPickerDelegate
//extension ConversationsListViewController: ThemesPickerDelegate {
//  func didChangeTheme(_ themesViewController: ThemesViewController) {
//    self.tableView.backgroundColor = ThemeHelper.shared.current.backgroundAppColor
//  }
//
//}

// MARK: - Functions
extension ConversationsListViewController {
  
  @objc
  private func close() {
    self.dismiss(animated: true)
  }
  
  @objc
  private func avatarTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    _ = tapGestureRecognizer.view as? MiniAvatarView
    openProfileVC()
  }
  
  private func openProfileVC() {
    let profileVC: ProfileViewController = ProfileViewController.loadFromStoryboard()
    self.present(profileVC, animated: true)
  }
  
  private func setupTableView() {
    tableView.rowHeight = 80
    tableView.register(UINib(nibName: ConversationTableViewCell.nibName, bundle: nil),
                       forCellReuseIdentifier: ConversationTableViewCell.reuseIdentifier)
  }
  
  private func setupSearchController() {
    //searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = NSLocalizedString("search", comment: "")
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
  
  private func setupMiniature() {
    dataManager.retrive { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let profile):
      self.setupInitialsOfName(profile: profile)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarTapped(tapGestureRecognizer:)))
    avatarView.isUserInteractionEnabled = true
    avatarView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  private func setupInitialsOfName(profile: Profile) {

    let fullNameArr = profile.userName.components(separatedBy: " ")
      let firstName: String = fullNameArr[0]
      let lastName: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil

      let firstInitial = String(firstName.first ?? " ")
      let secondInitial = String(lastName?.first ?? " ")

      avatarView.miniNameLabel.text = firstInitial
      avatarView.miniSecondNameLabel.text = secondInitial
      avatarView.miniImageView.image = UIImage(data: profile.userData)

    if avatarView.miniImageView.image != nil {
      avatarView.hideInitials()
    }
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ConversationsListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return channels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueCell(ConversationTableViewCell.self, for: indexPath)
    cell.configure(model: channels[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let conversationVC: ConversationViewController = ConversationViewController.loadFromStoryboard()
    conversationVC.title = channels[indexPath.row].name
    conversationVC.channel = channels[indexPath.row]
    self.navigationController?.pushViewController(conversationVC, animated: true)
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    navigationItem.hidesSearchBarWhenScrolling = true
  }
}
