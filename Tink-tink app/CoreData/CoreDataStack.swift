//
//  CoreDataStack.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 23.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import CoreData
import os.log

final class CoreDataStack {
  
  static let shared = CoreDataStack()
  private init() {}
  
  var didUpdateDataBase: ((CoreDataStack) -> Void)?
  // MARK: - storeUrl
  private var storeUrl: URL = {
    guard let documentsUrl = FileManager.default.urls(for: .documentDirectory,
                                                      in: .userDomainMask).last
    else { fatalError("document path not found") }
    
    return documentsUrl.appendingPathComponent("Chat.sqlite")
  }()
  
  private let dataModelName = "Chat"
  private let dataModelExtension = "momd"
  
  // MARK: - init stack
  
  //Load our scheme
  private(set) lazy var managedObjectModel: NSManagedObjectModel = {
    guard let modelURL = Bundle.main.url(forResource: self.dataModelName,
                                         withExtension: self.dataModelExtension)
    else { fatalError("model not found")}
    
    guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
    else { fatalError("managedObjectModel could't be created")}
    return managedObjectModel
  }()
  
  //Coordinator
  private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    do {
      //конфигурирует store
      //желательно сделать отдельную очередь для конфигугрирования  persistentStore
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                         configurationName: nil,
                                         at: self.storeUrl,
                                         options: nil)
    } catch {
      fatalError(error.localizedDescription)
    }
    return coordinator
  }()
  
  // MARK: - Contexts
  //работает непосредственно со стором
  private lazy var masterContext: NSManagedObjectContext = {
    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    context.persistentStoreCoordinator = persistentStoreCoordinator
    //полная перезапись объектов которую надо изменить
    context.mergePolicy = NSOverwriteMergePolicy
    return context
  }()
  
  private(set) lazy var mainContext: NSManagedObjectContext = {
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    //его родителем является writterContext
    context.parent = masterContext
    context.automaticallyMergesChangesFromParent = true
    context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    return context
  }()
  
  private func saveContext() -> NSManagedObjectContext {
    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    //его родителем является mainContext
    context.parent = mainContext
    context.automaticallyMergesChangesFromParent = true
    context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    return context
  }
  
  // MARK: - Save context
  
  func performSave(_ block: (NSManagedObjectContext) -> Void) {
    let  context = saveContext()
    //блок сохранения будет выполняться последовательно
    context.performAndWait {
      block(context)
      if context.hasChanges {
        do {
          try performSave(in: context)
          
        } catch {
          assertionFailure(error.localizedDescription)
          
        }
      }
    }
  }
  
  private func performSave(in context: NSManagedObjectContext)  throws {
    try context.save()
    if let parent = context.parent {
      parent.performAndWait {
        if parent.hasChanges {
          do {
            try performSave(in: parent)
            os_log("Saved sucessfully in parent context", log: OSLog.coreData, type: .info)
          } catch {
            assertionFailure(error.localizedDescription)
          }
        }
      }
    } else {
      os_log("Saved sucessfully", log: OSLog.coreData, type: .info)
    }
  }
  
  func enableObservers() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,
                                   selector: #selector(managedObjectContextObjectsChange(notification:)),
                                   name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                   object: mainContext)
  }
  
  @objc
  private func managedObjectContextObjectsChange(notification: NSNotification) {
    guard let userInfo = notification.userInfo else { return }
    
    didUpdateDataBase?(self)
    
      if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>,
         inserts.count > 0 {
        print("Add objects: ", inserts.count)
      }
      if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>,
         updates.count > 0 {
        print("Update objects: ", updates.count)
      }
      if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>,
         deletes.count > 0 {
        print("Delete objects: ", deletes.count)
      }
  }
  
  func printDatabaseStatistics() {
      mainContext.perform {
        do {
          let count = try self.mainContext.count(for: Channel_db.fetchRequest())
          print("Saved channels: ", count)
          let countMessages = try self.mainContext.count(for: Message_db.fetchRequest())
          print("Saved messages: ", countMessages)

        } catch {
          fatalError(error.localizedDescription)
        }
      }
  }
}
