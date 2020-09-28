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

class ConversationsListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var displaySecondButton = UIButton()
  
  var chats = [
    ConversationCellModel(avatar: nil, name: "Alena Иванова", message: "Привет! Как дела? Пошли в кино сегодня вечером?", date: Date(), isOnline:  true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Кристина Стоцкая", message:"Нормально, работаю, учусть, поступила вот на курсы", date: Date(), isOnline:  true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Aлександр Вермутов", message: "", date: Date(),isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Данила Козловский", message: "", date: Date(), isOnline:  true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Кети Перри", message:"Как дела", date: Date(), isOnline: false, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Арнольд Шварценегер", message: "Нормально", date: Date(),isOnline: true, hasUnreadMessages: true),
    ConversationCellModel(avatar: nil, name: "Вася Петров", message: "Привет!", date: Date(), isOnline: true, hasUnreadMessages: true),
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
  
  var sections = [TypeSection]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Chats"
    self.navigationController?.navigationBar.backgroundColor = .white
    self.navigationController?.navigationBar.prefersLargeTitles = true
    setupTableView()
    createRightBar()
  }
}

extension ConversationsListViewController {
  
  fileprivate func createRightBar() {
    let profileButton = UIButton()
    profileButton.addTarget(self, action: #selector(perfAdd), for: .touchUpInside)
    profileButton.translatesAutoresizingMaskIntoConstraints = false
    self.navigationItem.title = title
    let barBurronItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(perfAdd(_sender:)))
    self.navigationItem.rightBarButtonItem = barBurronItem
  }
  
  @objc func perfAdd(_sender: UIBarButtonItem) {
    let profileVC: ProfileViewController = ProfileViewController.loadFromStoryboard()
    self.present(profileVC, animated: true)
  }
  
  fileprivate func setupTableView() {
    self.sections = TypeSection.group(chats: chats)
    tableView.rowHeight = 80
    tableView.estimatedRowHeight = 350
    tableView.register(UINib(nibName: ConversationTableViewCell.nibName, bundle: nil),
                       forCellReuseIdentifier: ConversationTableViewCell.reuseIdentifier)
  }
  
  fileprivate func createDisplaySecondButton() {
    self.displaySecondButton = UIButton(type: .system)
    self.displaySecondButton.setTitle("Second VC", for: .normal)
    self.displaySecondButton.sizeToFit()
    self.displaySecondButton.center = self.view.center
    self.displaySecondButton.addTarget(self, action: #selector(performDisplaySecondVC(_:)), for: .touchUpInside)
    tableView.headerView(forSection: 0)?.addSubview(displaySecondButton)
  }
  
  @objc func performDisplaySecondVC(_ sender: Any) {
    let secondVC: ProfileViewController = ProfileViewController.loadFromStoryboard()
    self.navigationController?.pushViewController(secondVC, animated: true)
  }
}



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
}
