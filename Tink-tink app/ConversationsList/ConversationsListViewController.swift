//
//  ConversationsListViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 27.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

struct TypeSection {
  var title: String
  var isOnline: Bool
  var chats: [ConversationCellModel]
}

final class ConversationsListViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var avatarView: MiniAvatarView!
  
  private var sections = [TypeSection]()
  private var chats = [
    ConversationCellModel(avatar: nil, name: "Alena Иванова", message: "Привет! Как дела? Пошли в кино сегодня вечером?", date: Date(timeIntervalSinceNow: -184000), isOnline:  true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Кристина Стоцкая", message:"Нормально, работаю, учусть, поступила вот на курсы", date: Date(), isOnline:  true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Aлександр Вермутов", message: "", date: Date(),isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Данила Козловский", message: "", date: Date(timeIntervalSinceNow: -90000), isOnline:  true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Кети Перри", message:"Как дела", date: Date(), isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Арнольд Шварценегер", message: "Нормально", date: Date(timeIntervalSinceNow: -356000),isOnline: true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Вася Петров", message: "", date: Date(), isOnline: true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Юлия Поздеева", message:"Как дела", date: Date(), isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Антонина Федорова", message: "Нормально", date: Date(),isOnline: false, hasUnreadMessages: false),
    ConversationCellModel(avatar: nil, name: "Кот Лепольд", message: "Привет!", date: Date(), isOnline:  false, hasUnreadMessages: false),
    ConversationCellModel(avatar: nil, name: "Шелдон Купер", message:"Как дела", date: Date(), isOnline:  true, hasUnreadMessages: false),
    ConversationCellModel(avatar: nil, name: "Раджеш Кутрапалли", message: "", date: Date(),isOnline: true, hasUnreadMessages: false),
    ConversationCellModel(avatar: nil, name: "Леонард Хофстедер", message: "Привет!", date: Date(), isOnline:  true, hasUnreadMessages: false),
    ConversationCellModel(avatar: nil, name: "Говард Воловиц", message:"Как дела", date: Date(), isOnline: false, hasUnreadMessages: false),
    ConversationCellModel(avatar: nil, name: "Бернадет Ростенковски", message: "Нормально", date: Date(),isOnline: true, hasUnreadMessages: false),
    ConversationCellModel(avatar: nil, name: "Эми Фарафаулер", message: "Привет!", date: Date(), isOnline: true, hasUnreadMessages: false),
    ConversationCellModel(avatar: nil, name: "Пенни Сидорова", message:"Как дела", date: Date(), isOnline: true, hasUnreadMessages: false),
    ConversationCellModel(avatar: nil, name: "Серега Пеннивайз", message: "Нормально", date: Date(),isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Андрей Малахов", message: "Привет!", date: Date(), isOnline:  true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Анатолий Собчак", message:"Как дела", date: Date(), isOnline:  false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Кейт Мидлтон", message: "", date: Date(),isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Илон Маск", message: "Привет!", date: Date(), isOnline:  true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Квентин Тарантино", message:"Как дела", date: Date(), isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Ума Турман", message: "Нормально", date: Date(),isOnline: true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Волтер Уайт", message: "Привет!", date: Date(), isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Джесси Пинкман", message:"Как дела", date: Date(), isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Сол Гудман", message: "Нормально", date: Date(),isOnline: false, hasUnreadMessages: true)
  ]
  private var searchController = UISearchController(searchResultsController: nil)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    // createRightBar()
    setupSearchController()
    avatarView.miniNameLabel.text = "A"
    avatarView.miniSecondNameLabel.text = "L"
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(avatarTapped(tapGestureRecognizer:)))
    avatarView.isUserInteractionEnabled = true
    avatarView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  
  @IBAction func settingsTapped(_ sender: UIBarButtonItem) {
    
    let themesVC: ThemesViewController = ThemesViewController.loadFromStoryboard()
    themesVC.didTapThemeButton = { color in
      self.tableView.backgroundColor = color
    }
    self.navigationController?.pushViewController(themesVC, animated: true)
  }
  
  
}

//MARK: - Functions
extension ConversationsListViewController {
  
  @objc
  private func close() {
    self.dismiss(animated: true)
  }
  
  @objc
  private func avatarTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    let _ = tapGestureRecognizer.view as! MiniAvatarView
    openProfileVC()
  }
  
  private func openProfileVC() {
    let profileVC: ProfileViewController = ProfileViewController.loadFromStoryboard()
    self.present(profileVC, animated: true)
  }
  
  private func setupTableView() {
    self.sections = TypeSection.group(chats: chats)
    sections[1].chats = filteredMessagesInHistory()
    tableView.rowHeight = 80
    tableView.register(UINib(nibName: ConversationTableViewCell.nibName, bundle: nil),
                       forCellReuseIdentifier: ConversationTableViewCell.reuseIdentifier)
  }
  
  private func filteredMessagesInHistory() -> [ConversationCellModel] {
    return sections[1].chats.filter { chat in
      chat.message != ""
    }
  }
  
  private func setupSearchController() {
    //searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = NSLocalizedString("search", comment: "")
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension ConversationsListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    sections.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let section = self.sections[section]
    
    return section.chats.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].title
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = self.sections[indexPath.section]
    
    let cell = tableView.dequeueCell(ConversationTableViewCell.self, for: indexPath)
    cell.configure(model: section.chats[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let section = self.sections[indexPath.section]
    let conversationVC: ConversationViewController = ConversationViewController.loadFromStoryboard()
    conversationVC.title = section.chats[indexPath.row].name
    self.navigationController?.pushViewController(conversationVC, animated: true)
    
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    navigationItem.hidesSearchBarWhenScrolling = true
  }
}
