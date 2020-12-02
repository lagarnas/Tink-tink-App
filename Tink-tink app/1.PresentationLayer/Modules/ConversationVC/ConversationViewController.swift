//
//  ConversationViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 28.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import CoreData

final class ConversationViewController: UIViewController {
  
  @IBOutlet weak var messageTextField: UITextField!
  @IBOutlet private weak var sendButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var dockViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var dockView: UIView!
  
  @IBOutlet weak var emblemView: EmblemParticleView!
  
  private var keyboardHeight: CGFloat = 0
  var channel: Channel_db!
  
  //DEPENDENCY
  var model: IConversationModel!
  var themeModel: IThemeModel!
  
  // MARK: - FetchedResultsController
  var fetchedResultsController: NSFetchedResultsController<Message_db>!
  
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
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    print(#function)
    emblemView.stopAnimation()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    emblemView.stopAnimation()
  }
  
  func setupDepenencies(model: IConversationModel, themeModel: IThemeModel?, presentationAssembly: IPresentationAssembly?) {
    self.model = model
    self.themeModel = themeModel
  }
  
  // MARK: - Private methods
  private func loadMessages() {
    guard let model = self.model else { return }
    model.getMessages(channel: channel)
    fetchedResultsController = model.fetchedResultController(channel: channel)
    try? self.fetchedResultsController.performFetch()
    self.fetchedResultsController.delegate = self        
  }
  
  override func viewWillLayoutSubviews() {
      self.scrollToBottom()
  }
  
  private func scrollToBottom(){
    emblemView.stopAnimation()
    guard let item = self.fetchedResultsController.fetchedObjects?.count
    else { return }
    let indexPath = IndexPath(item: item - 1, section: 0)
    if indexPath != [0, -1] {
      self.tableView.scrollToRow(at:  indexPath, at: .bottom, animated: true)
    }
  }
  
  // MARK: - @IBActions
  @IBAction private func sendButtonTapped(_ sender: Any) {
    emblemView.stopAnimation()
    self.messageTextField.endEditing(true)
    guard let channel = self.channel else { return }
    guard let message = messageTextField.text else { return }
    guard message != "" else { return }
    guard let channelId = channel.identifier, let model = self.model else { return }
    model.insertMessage(channelId: channelId, message: message)
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
    emblemView.stopAnimation()
    self.messageTextField.endEditing(true)
  }
  
  @objc
  private func handle(keyboardShowNotification notification: Notification) {
    emblemView.stopAnimation()
    if let userInfo = notification.userInfo,
       let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
       let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
      self.keyboardHeight = keyboardRectangle.height
      UIView.animate(withDuration: duration, animations: {
        self.dockViewHeightConstraint.constant = self.keyboardHeight + 25 + 34
        self.view.layoutIfNeeded()
      }, completion: nil)
    }
  }
}
