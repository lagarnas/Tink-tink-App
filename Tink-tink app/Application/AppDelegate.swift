//
//  AppDelegate.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  
  var window: UIWindow?
  // 1) Запускаем приложение по тапу на иконку
  //  State: Приложение запускается, не активно
  // 2) Ждем пока приложение загрузится смотрим на LaunchScreen
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    NSLog("Application moved from <Not Running> to <Inactive>: \(#function)")
    //print("Application moved from <Not Running> to <Inactive>: \(#function)")
    self.window = UIWindow(frame: UIScreen.main.bounds)

    let storyboard = UIStoryboard(name: "ProfileViewController", bundle: nil)

    let initialViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")

    self.window?.rootViewController = initialViewController
    self.window?.makeKeyAndVisible()

    return true

  }
  // State: Приложение стало активным
  // 3) Можем взаимодействовать с ним
  func applicationDidBecomeActive(_ application: UIApplication) {
    NSLog("Application moved from <Inactive> to <Active>: \(#function)")
  }
  // 4) Свернули приложение
  // State: Приложение станет не активным
  func applicationWillResignActive(_ application: UIApplication) {
    NSLog("Application moved from <Active> to <Inactive>: \(#function)")
    
  }
  // 5) Приложение свернуто, открыли другое приложение
  //State: Приложение ушло в Background
  func applicationDidEnterBackground(_ application: UIApplication) {
    NSLog("Application moved from <Inactive> to <Background>, <Suspended>: \(#function)")
    
  }
  // 6) Снова открываем приложение из background
  // State: Приложение переходит в Foreground и становится активным applicationDidBecomeActive
  func applicationWillEnterForeground(_ application: UIApplication) {
    NSLog("Application moved from <Background> to <Inactive>: \(#function)")
  }
  
  // 7) Закрываем приложение, смахиваем его
  // State: Приложение закрвается и становится не запущенным
  func applicationWillTerminate(_ application: UIApplication) {
    NSLog("Application moved from <Background> to <Suspended> to <Not Running>: \(#function)")
  }
}

