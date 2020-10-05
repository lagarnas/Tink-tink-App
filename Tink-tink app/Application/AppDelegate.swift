//
//  AppDelegate.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import os.log

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
  
  
  var window: UIWindow?
  var navController = UINavigationController()
  // 1) Запускаем приложение по тапу на иконку
  //  State: Приложение запускается, не активно
  // 2) Ждем пока приложение загрузится смотрим на LaunchScreen
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
    self.window = UIWindow(frame: UIScreen.main.bounds)

    let convVC: ConversationsListViewController = ConversationsListViewController.loadFromStoryboard()
    self.navController = UINavigationController(rootViewController: convVC)
    
    self.window?.rootViewController = self.navController
    self.window?.makeKeyAndVisible()
    
    os_log("Application moved from <Not Running> to <Inactive>: didFinishLaunchingWithOptions", log: OSLog.appCycle, type: .info)

    return true

  }
  // State: Приложение стало активным
  // 3) Можем взаимодействовать с ним
  func applicationDidBecomeActive(_ application: UIApplication) {
    os_log("Application moved from <Inactive> to <Active>: applicationDidBecomeActive", log: OSLog.appCycle, type: .info)
  }
  // 4) Свернули приложение
  // State: Приложение станет не активным
  func applicationWillResignActive(_ application: UIApplication) {
    os_log("Application moved from <Active> to <Inactive>: applicationWillResignActive", log: OSLog.appCycle, type: .info)
  }
  // 5) Приложение свернуто, открыли другое приложение
  //State: Приложение ушло в Background
  func applicationDidEnterBackground(_ application: UIApplication) {
    os_log("Application moved from <Inactive> to <Background>, <Suspended>: applicationDidEnterBackground", log: OSLog.appCycle, type: .info)
  }
  // 6) Снова открываем приложение из background
  // State: Приложение переходит в Foreground и становится активным applicationDidBecomeActive
  func applicationWillEnterForeground(_ application: UIApplication) {
    os_log("Application moved from <Background> to <Inactive>: applicationWillEnterForeground", log: OSLog.appCycle, type: .info)
  }
  
  // 7) Закрываем приложение, смахиваем его
  // State: Приложение закрвается и становится не запущенным
  func applicationWillTerminate(_ application: UIApplication) {
    os_log("Application moved from <Background> to <Suspended> to <Not Running>: applicationWillTerminate", log: OSLog.appCycle, type: .info)
  }
}

