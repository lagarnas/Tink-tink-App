//
//  VC+UITableViewDelegate, UITableViewDataSource.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

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
