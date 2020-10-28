//
//  ThemesViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 02.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import os.log

protocol ThemesPickerDelegate: class {
  func didChangeTheme(_ themesViewController: ThemesViewController)
}

final class ThemesViewController: UIViewController {
  
  @IBOutlet private weak var classicButton: ThemeButton!
  @IBOutlet private weak var dayButton: ThemeButton!
  @IBOutlet private weak var nightButton: ThemeButton!
  
  @IBOutlet private weak var classicLabel: UILabel!
  @IBOutlet private weak var dayLabel: UILabel!
  @IBOutlet private weak var nightLabel: UILabel!
  
  private var themeMode: ThemeMode = .classic
  
  // MARK: Delegate
  //  weak var delegate: ThemesPickerDelegate?
  
  // MARK: Closure
  var didChangeTheme: (() -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupUI()
    applyTheme()
  }
  
  @IBAction private func classicButtonTapped(_ sender: ThemeButton) {
    unSelectAll()
    sender.isSelected = true
    themeMode = .classic
    updateTheme()
    sender.shake()
    
    //delegate?.didChangeTheme(self)
    
    didChangeTheme?()
    
  }
  
  @IBAction private func dayButtonTapped(_ sender: ThemeButton) {
    unSelectAll()
    sender.isSelected = true
    themeMode = .day
    updateTheme()
    sender.shake()
    
    // delegate?.didChangeTheme(self)
    
    didChangeTheme?()
  }
  
  @IBAction private func nightButtonTapped(_ sender: ThemeButton) {
    unSelectAll()
    sender.isSelected = true
    themeMode = .night
    updateTheme()
    sender.shake()
    
    //delegate?.didChangeTheme(self)
    
    didChangeTheme?()
  }
  
  deinit {
    os_log("%@", log: .retainCycle, type: .info, self)
  }
  
}

extension ThemesViewController {
  
  private func unSelectAll() {
    classicButton.isSelected = false
    dayButton.isSelected = false
    nightButton.isSelected = false
  }
  
  private func updateTheme() {
   // saveTheme()
    ThemeManager.shared.save(themeMode: self.themeMode) {
      self.applyTheme()
      self.didChangeTheme?()
    }
    
  }
  
  private func applyTheme() {
    ThemeManager.shared.applyTheme()
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
    let labelTap = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
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

  private func saveTheme() {

  //  ThemeManager.shared.save(themeMode: self.themeMode, completion: <#() -> Void#>)
    
  }
}
