//
//  ViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 11.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // Загрузка вью
  override func loadView() {
    super.loadView()
    NSLog(#function)
  }
  
  // Вью загружена
  override func viewDidLoad() {
    super.viewDidLoad()
    NSLog(#function)
  }
  // Вью начинает появляться
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NSLog(#function)
  }
  
  // Вот вот у вью изменятся фреймы будь осторожен
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    NSLog(#function)
  }
  // Ну вот фреймы изменились, надеюсь ты успел?
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    NSLog(#function)
  }
  
  // Вью появилась
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    NSLog(#function)
  }
  
  // Вью вот вот исчезнет
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NSLog(#function)
  }
  // Вью исчезла =(
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NSLog(#function)
  }
  
  //Оповещает что у телефона нехватка памяти
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    NSLog(#function)
  }
}

