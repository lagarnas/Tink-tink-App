//
//  ConversationsListViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 27.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import os.log
import CoreData

final class ConversationsListViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var avatarView: MiniAvatarView!
  @IBOutlet private weak var settingsIcon: UIBarButtonItem!
  private var searchController = UISearchController(searchResultsController: nil)
  
  //DEPENDENCY
  var presentationAssembly: IPresentationAssembly?
  var model: IConversationsListModel?
  var themeModel: IThemeModel?
  
  // MARK: - FetchedResultsController
  private var fetchedResultsController: NSFetchedResultsController<Channel_db>!
  
  // MARK: - Lifecycle of VC
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
    guard let model = self.model else { return }
    model.getChannels()
    self.fetchedResultsController = model.fetchedResultController()
    try? self.fetchedResultsController.performFetch()
    self.fetchedResultsController.delegate = self
  }
  
  private func updateTheme() {
    guard let themeModel = self.themeModel else { return }
    themeModel.applyTheme()
    self.view.backgroundColor = themeModel.current.backgroundAppColor
    self.tableView.backgroundColor = themeModel.current.backgroundAppColor
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeModel.current.mainTextColor]
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: themeModel.current.mainTextColor]
    settingsIcon.tintColor = themeModel.current.tintColor
  }
  
  // MARK: - @IBActions
  @IBAction func addChannelButtonTapped(_ sender: Any) {
    showChannelAlert()
  }
  
  @IBAction func settingsTapped(_ sender: UIBarButtonItem) {
    let themesVC = presentationAssembly?.themesViewController()
    guard let vc = themesVC else { return }
    
    vc.didChangeTheme = { [weak self] in
      self?.updateTheme()
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  deinit {
    os_log("%@", log: .retainCycle, type: .info, self)
  }
}

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
    guard let presentationAssembly = self.presentationAssembly else { return }
    let profileVC = presentationAssembly.profileViewController()
    self.present(profileVC, animated: true)
  }
  
  private func setupTableView() {
    tableView.rowHeight = 80
    tableView.register(UINib(nibName: ConversationTableViewCell.nibName, bundle: nil),
                       forCellReuseIdentifier: ConversationTableViewCell.reuseIdentifier)
  }
  
  private func setupSearchController() {
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = NSLocalizedString("search", comment: "")
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
  
  private func setupMiniature() {
    guard let model = self.model else { return }
    model.retriveProfile { [weak self] result in
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
    guard let sections = fetchedResultsController?.sections else { return 0 }
    return sections[section].numberOfObjects
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueCell(ConversationTableViewCell.self, for: indexPath)
    let channel = fetchedResultsController.object(at: indexPath)
    cell.themeModel = themeModel
    cell.configure(model: channel)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let presentationAssembly = self.presentationAssembly else { return }
    let conversationVC = presentationAssembly.conversationViewController()
    let channel = fetchedResultsController.object(at: indexPath)
    conversationVC.title = channel.name
    conversationVC.channel = channel
    self.navigationController?.pushViewController(conversationVC, animated: true)
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    navigationItem.hidesSearchBarWhenScrolling = true
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    .delete
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let channel = fetchedResultsController.object(at: indexPath)
      guard let model = self.model else { return }
      model.deleteChannel(channel: channel)
    }
  }
  
}

extension ConversationsListViewController: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                  didChange anObject: Any,
                  at indexPath: IndexPath?,
                  for type: NSFetchedResultsChangeType,
                  newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
    case .update:
      tableView.reloadRows(at: [indexPath!], with: .automatic)
    case .move:
      tableView.deleteRows(at: [indexPath!], with: .automatic)
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .automatic)
    @unknown default:
      fatalError()
    }
  }
}

extension ConversationsListViewController {
  
  func showChannelAlert() {
    let alertController = UIAlertController(title: "New channel", message: nil, preferredStyle: .alert)
    
    let createAction = UIAlertAction(title: "Create", style: .default) {_ in
      let text = alertController.textFields?.first?.text
      guard let channelName = text, let model = self.model else { return }
      model.insertChannel(name: channelName)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addTextField { (textField) in
      textField.placeholder = "Add new channel"
    }
    alertController.addAction(createAction)
    alertController.addAction(cancelAction)
    
    self.present(alertController, animated: true, completion: nil)
  }
}
