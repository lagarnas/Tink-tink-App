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
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var avatarView: MiniAvatarView!
  @IBOutlet weak var settingsIcon: UIBarButtonItem!
  private var searchController = UISearchController(searchResultsController: nil)
  
  //DEPENDENCY
  private var presentationAssembly: IPresentationAssembly!
  var model: IConversationsListModel!
  var themeModel: IThemeModel!
  
  // MARK: - FetchedResultsController
  var fetchedResultsController: NSFetchedResultsController<Channel_db>!
  
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
  
  func setupDepenencies(model: IConversationsListModel, themeModel: IThemeModel?, presentationAssembly: IPresentationAssembly?) {
    self.model = model
    self.themeModel = themeModel
    self.presentationAssembly = presentationAssembly
  }
  
  // MARK: - Private methods
  private func loadChannels() {
    guard let model = self.model else { return }
    model.getChannels()
    self.fetchedResultsController = model.fetchedResultController()
    try? self.fetchedResultsController.performFetch()
    self.fetchedResultsController.delegate = self
  }
  
  // MARK: - @IBActions
  @IBAction private func addChannelButtonTapped(_ sender: Any) {
    showChannelAlert()
  }
  
  @IBAction private func settingsTapped(_ sender: UIBarButtonItem) {
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
}
