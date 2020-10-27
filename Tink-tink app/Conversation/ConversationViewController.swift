//
//  ConversationViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 28.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

final class ConversationViewController: UIViewController {
  
  @IBOutlet weak var messageTextField: UITextField!
  @IBOutlet private weak var sendButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var dockViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var dockView: UIView!
  
  private var keyboardHeight: CGFloat = 0
  private var messages = [Message]()
  var channel: Channel?
  
  // MARK: - Lifecycle of VC
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handle(keyboardShowNotification:)),
                                           name: UIResponder.keyboardDidShowNotification,
                                           object: nil)
    self.navigationController?.navigationBar.prefersLargeTitles = false
    self.messageTextField.delegate = self
    setupTableView()
    updateTheme()
    loadMessages()
  }
  
  // MARK: - Private methods
  private func loadMessages() {
    FirebaseManager.shared.getMessages(channel: channel!) { (result) in
      switch result {
      case .success(let messages):
        self.messages = messages.sorted {
          $0.created < $1.created
        }
        self.tableView.reloadData()
        self.scrollToBottom()
      case .failure( _): break
      }
    }
  }
  
  private func scrollToBottom(){
    let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
    if indexPath != [0, -1] {
      self.tableView.scrollToRow(at:  indexPath, at: .bottom, animated: true)
    }
  }

  // MARK: - @IBActions
  @IBAction private func sendButtonTapped(_ sender: Any) {
    self.messageTextField.endEditing(true)
    guard let channel = self.channel else { return }
    guard let message = messageTextField.text else { return }
    guard message != "" else { return }
      
    FirebaseManager.shared.insertMessage(channelId: channel.identifier, message: message)
      self.messageTextField.text = ""
  }
}

// MARK: - Setup TableView
extension ConversationViewController {
  private func setupTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
    tableView.register(UINib(nibName: IncomingMessageTableViewCell.nibName, bundle: nil),
                       forCellReuseIdentifier: IncomingMessageTableViewCell.reuseIdentifier)
    tableView.register(UINib(nibName: OutgoingMessageTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: OutgoingMessageTableViewCell.reuseIdentifier)
    tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
    self.tableView.addGestureRecognizer(tapGesture)
  }
  
  @objc
  private func tableViewTapped() {
    self.messageTextField.endEditing(true)
  }
  
  @objc
  private func handle(keyboardShowNotification notification: Notification) {
    if let userInfo = notification.userInfo,
       let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
       let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
      self.keyboardHeight = keyboardRectangle.height
      UIView.animate(withDuration: duration, animations: {
        //временное решение
        self.dockViewHeightConstraint.constant = self.keyboardHeight + 25 + 34
        self.view.layoutIfNeeded()
      }, completion: nil)
    }
  }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ConversationViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let chatMessage = messages[indexPath.row]
    if chatMessage.senderId == FirebaseManager.shared.senderId {
      let cell = tableView.dequeueCell(OutgoingMessageTableViewCell.self, for: indexPath)
      cell.configure(model: chatMessage)
      return cell
      
    } else {
      let cell = tableView.dequeueCell(IncomingMessageTableViewCell.self, for: indexPath)
      cell.configure(model: chatMessage)
      return cell
    }
  }
}
