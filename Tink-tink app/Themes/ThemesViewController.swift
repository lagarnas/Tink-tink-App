//
//  ThemesViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 02.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

enum ThemeMode: Int {
  case classic, day, night
}

protocol ThemesPickerDelegate: class {
  func didChangeTheme(_ themesViewController: ThemesViewController)
}

class ThemesViewController: UIViewController {
  
  @IBOutlet weak var classicButton: ThemeButton!
  @IBOutlet weak var dayButton: ThemeButton!
  @IBOutlet weak var nightButton: ThemeButton!
  
  @IBOutlet weak var classicLabel: UILabel!
  @IBOutlet weak var dayLabel: UILabel!
  @IBOutlet weak var nightLabel: UILabel!
  
  var themeMode: ThemeMode = .classic
  
  //MARK: Delegate
  //Retains cycle возникнет если будет сильная ссылка на этот VC, с другого VC (Наглядно это видно с ProfileVC, так как он закрывается и сразу видно уничтожается ли он или нет) и соответственно сильная ссылка на ProfileVC (vc.delegate = self) Если не сделать одну из этих ссылок weak (разница будет ли в том в каком порядке они будут уничтожаться), то объект не уничтожится и будет висеть в памяти (соответсвеено deinit не вызовится).Поэтому либо делаем переменную delegate weak, либо переменную themesVC. Но обычно delagate делают weak. (Если что, я удалила код связанный с этим из ProfileVC). Аналогичная ситуация если рассматривать ConverationsListVC, просто там не будет видно уничтожены ли объекты или нет, так как ConverationsListVC уничтожается только когда мы закрываем приложение. Там я создаю ссылку на ThemesVC внутри @IBAction settingsTapped() и сразу после отработки этого метода объект уничтожается  и его не держит никто значит на ThemesVC не будет ссылки, поэтому тут и без weak будут уничтожаться VC. Но я тут оставлю weak все равно, так привычно)
  //  weak var delegate: ThemesPickerDelegate?
  //MARK: Closure
  var didChangeTheme: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupUI()
    applyTheme()
  }
  
  
  @IBAction func classicButtonTapped(_ sender: ThemeButton) {
    unSelectAll()
    sender.isSelected = true
    themeMode = .classic
    updateTheme()
    sender.shake()
    
    //delegate?.didChangeTheme(self)
    
    didChangeTheme?()
    
  }
  
  @IBAction func dayButtonTapped(_ sender: ThemeButton) {
    unSelectAll()
    sender.isSelected = true
    themeMode = .day
    updateTheme()
    sender.shake()
    
    // delegate?.didChangeTheme(self)
    
    didChangeTheme?()
  }
  
  
  @IBAction func nightButtonTapped(_ sender: ThemeButton) {
    unSelectAll()
    sender.isSelected = true
    themeMode = .night
    updateTheme()
    sender.shake()
    
    //delegate?.didChangeTheme(self)
    
    didChangeTheme?()
  }
  
  deinit {
    print("deinit: ThemesViewController")
  }
  
}

extension ThemesViewController {
  
  private func unSelectAll() {
    classicButton.isSelected = false
    dayButton.isSelected = false
    nightButton.isSelected = false
  }
  
  
  private func updateTheme() {
    saveStates()
    applyTheme()
  }
  
  private func applyTheme() {
    view.backgroundColor = ThemeManager.shared.current.backgroundAppColor
    classicLabel.textColor = ThemeManager.shared.current.mainTextColor
    dayLabel.textColor = ThemeManager.shared.current.mainTextColor
    nightLabel.textColor = ThemeManager.shared.current.mainTextColor
  }
  
  private func setupNavigation() {
    self.title = "Settings"
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  private func setupUI() {
    
    themeMode = ThemeManager.shared.currentMode
    
    switch themeMode {
    case .classic:
      classicButton.isSelected = true
    case .day:
      dayButton.isSelected = true
    case .night:
      nightButton.isSelected = true
    }
    
    setupLabelTapRecognizer(label: classicLabel)
    setupLabelTapRecognizer(label: dayLabel)
    setupLabelTapRecognizer(label: nightLabel)
  }
  
  private func setupLabelTapRecognizer(label: UILabel) {
    let labelTap = UITapGestureRecognizer (target: self, action: #selector(labelTapped))
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(labelTap)
  }
  
  @objc
  private func labelTapped(_ sender: UITapGestureRecognizer) {
    switch sender.view {
    case classicLabel:
      classicButtonTapped(classicButton)
    case dayLabel:
      dayButtonTapped(dayButton)
    case nightLabel:
      nightButtonTapped(nightButton)
    default:
      break
    }
  }
  
  
  private func saveStates() {
    ThemeManager.shared.saveStates(themeMode: themeMode)
  }
}
