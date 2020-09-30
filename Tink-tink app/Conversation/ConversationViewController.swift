//
//  ConversationViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 28.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

struct ChatMessage {
  let text: MessageCellModel
  let isIncoming: Bool
}

final class ConversationViewController: UIViewController {
  
  @IBOutlet private weak var messageTextField: UITextField!
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var sendButton: UIButton!
  @IBOutlet private weak var dockViewHeightConstraint: NSLayoutConstraint!
  
  private let allChatMessages = [
    ChatMessage(text: MessageCellModel(text: "Привет как дела нормально как в школе"), isIncoming: true),
    ChatMessage(text: MessageCellModel(text: "Привет как дела нормально как в школе,Привет как дела нормально как в школе,Привет как дела нормально как в школе,Привет как дела нормально как в школе"), isIncoming: true),
    ChatMessage(text: MessageCellModel(text: "Привет"), isIncoming: false),
    ChatMessage(text: MessageCellModel(text: "Привет как дела нормально как в школе,Привет как дела нормально как в школе"), isIncoming: true),
    ChatMessage(text: MessageCellModel(text: "Привет как дела?"), isIncoming: false),
    ChatMessage(text: MessageCellModel(text: "Привет как дела нормально как в школе"), isIncoming: true),
    ChatMessage(text: MessageCellModel(text: "Привет как дела нормально как в школе,Привет как дела нормально как в школе,Привет как дела нормально как в школе,Привет как дела нормально как в школе"), isIncoming: true),
    ChatMessage(text: MessageCellModel(text: "Привет"), isIncoming: false),
    ChatMessage(text: MessageCellModel(text: "Привет как дела нормально как в школе,Привет как дела нормально как в школе"), isIncoming: true),
    ChatMessage(text: MessageCellModel(text: "Привет как дела?"), isIncoming: false),
    ChatMessage(text: MessageCellModel(text: "Привет как дела нормально как в школе"), isIncoming: true),
    ChatMessage(text: MessageCellModel(text: "Привет как дела нормально как в школе,Привет как дела нормально как в школе,Привет как дела нормально как в школе,Привет как дела нормально как в школе"), isIncoming: true),
    ChatMessage(text: MessageCellModel(text: "Привет"), isIncoming: false),
    ChatMessage(text: MessageCellModel(text: "Привет как дела нормально как в школе,Привет как дела нормально как в школе"), isIncoming: true),
    ChatMessage(text: MessageCellModel(text: "Привет как дела?"), isIncoming: false)
  ]
  private var keyboardHeight: CGFloat = 0
  
  //MARK: - Lifecycle of VC
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handle(keyboardShowNotification:)),
                                           name: UIResponder.keyboardDidShowNotification,
                                           object: nil)
    self.navigationController?.navigationBar.prefersLargeTitles = false
    self.messageTextField.delegate = self
    setupTableView()
    
  }
  
  private func createRightBarCustom() {
  }

  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let indexPath = IndexPath(item: self.allChatMessages.count-1, section: 0)
    self.tableView.scrollToRow(at:  indexPath, at: .bottom, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  //MARK: - @IBActions
  @IBAction private func sendButtonTapped(_ sender: Any) {
    self.messageTextField.endEditing(true)
  }
}

//MARK: - Setup TableView
extension ConversationViewController {
  
  private func setupTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 44
    tableView.register(UINib(nibName: IncomingMessageTableViewCell.nibName, bundle: nil),
                       forCellReuseIdentifier: IncomingMessageTableViewCell.reuseIdentifier)
    tableView.register(UINib(nibName: OutgoingMessageTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: OutgoingMessageTableViewCell.reuseIdentifier)
    
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

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ConversationViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    allChatMessages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let chatMessage = allChatMessages[indexPath.row]
    if chatMessage.isIncoming {
      let cell = tableView.dequeueCell(IncomingMessageTableViewCell.self, for: indexPath)
      cell.configure(model: chatMessage.text)
      return cell
    } else {
      let cell = tableView.dequeueCell(OutgoingMessageTableViewCell.self, for: indexPath)
      cell.configure(model: chatMessage.text)
      return cell
    }
  }
}

//MARK: - UITextFieldDelegate
extension ConversationViewController: UITextFieldDelegate {
  

  func textFieldDidEndEditing(_ textField: UITextField) {
    self.view.layoutIfNeeded()
    UIView.animate(withDuration: 0.5, animations: {
      self.dockViewHeightConstraint.constant = 80
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}
