//
//  ThemesViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 02.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import os.log

final class ThemesViewController: UIViewController {
  
  @IBOutlet private weak var classicButton: ThemeButton!
  @IBOutlet private weak var dayButton: ThemeButton!
  @IBOutlet private weak var nightButton: ThemeButton!
  
  @IBOutlet private weak var classicLabel: UILabel!
  @IBOutlet private weak var dayLabel: UILabel!
  @IBOutlet private weak var nightLabel: UILabel!
  
  private var themeMode: ThemeMode = .classic
  
  //DEPENDENCY
  var model: IThemeModel?
  
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
    
    didChangeTheme?()
  }
  
  @IBAction private func dayButtonTapped(_ sender: ThemeButton) {
    unSelectAll()
    sender.isSelected = true
    themeMode = .day
    updateTheme()
    sender.shake()
    
    didChangeTheme?()
  }
  
  @IBAction private func nightButtonTapped(_ sender: ThemeButton) {
    unSelectAll()
    sender.isSelected = true
    themeMode = .night
    updateTheme()
    sender.shake()
      
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
    model?.save(themeMode: themeMode) {
        self.applyTheme()
    }
  }
  
  private func applyTheme() {
    model?.applyTheme()
    view.backgroundColor = model?.current.backgroundAppColor
    view.backgroundColor = model?.current.backgroundAppColor
    classicLabel.textColor = model?.current.mainTextColor
    dayLabel.textColor = model?.current.mainTextColor
    nightLabel.textColor = model?.current.mainTextColor
  }
  
  private func setupNavigation() {
    self.title = "Settings"
    self.navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  private func setupUI() {
    guard let model = model else { return }
    themeMode = model.currentMode
    
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
    let labelTap = UITapGestureRecognizer(target: self,
                                          action: #selector(labelTapped))
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
}
