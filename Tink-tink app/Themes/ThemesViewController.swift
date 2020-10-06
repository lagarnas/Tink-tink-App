//
//  ThemesViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 02.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
  
  @IBOutlet private var themeButtons: [ThemeButton]!
  @IBOutlet private var themeLabels: [UILabel]!
  
  var didChangeTheme: ((Themeable) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupUI()
    applyTheme()
  }
  

  @IBAction
  private func themeButtonTapped(_ sender: ThemeButton) {
    themeButtons.forEach {
      $0.isSelected = $0 == sender ? true : false
    }
    switch sender {
    case themeButtons[0]:
      didChangeTheme?(ClassicTheme())
    case themeButtons[1]:
      didChangeTheme?(DayTheme())
    case themeButtons[2]:
      didChangeTheme?(NightTheme())
    default:
      break
    }
    sender.shake()
    saveStates()
    applyTheme()
  }
}

extension ThemesViewController {
  
  private func applyTheme() {
    view.backgroundColor = Theme.current.background
    themeLabels.forEach {
      $0.textColor = Theme.current.mainTextColor
    }
  }
  
  private func setupNavigation() {
    self.title = "Settings"
    self.navigationController?.navigationBar.prefersLargeTitles = false
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
  }
  
  private func setupUI() {
    if  !UserDefaults.standard.bool(forKey: "classicButton") &&
          !UserDefaults.standard.bool(forKey: "dayButton") &&
          !UserDefaults.standard.bool(forKey: "nightButton") {
      themeButtons[0].isSelected = true
    } else {
      themeButtons[0].isSelected = UserDefaults.standard.bool(forKey: "classicButton")
      themeButtons[1].isSelected = UserDefaults.standard.bool(forKey: "dayButton")
      themeButtons[2].isSelected = UserDefaults.standard.bool(forKey: "nightButton")
    }
    
    themeLabels.forEach { setupLabelTapRecognizer(label: $0) }
  }
  
  private func setupLabelTapRecognizer(label: UILabel) {
    let labelTap = UITapGestureRecognizer (target: self, action: #selector(labelTapped))
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(labelTap)
  }
  
  @objc
  private func labelTapped(_ sender: UITapGestureRecognizer) {
    switch sender.view {
    case themeLabels[0]:
      themeButtonTapped(themeButtons[0])
    case themeLabels[1]:
      themeButtonTapped(themeButtons[1])
    case themeLabels[2]:
      themeButtonTapped(themeButtons[2])
    default:
      break
    }
  }
  
  @objc private func dismissVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  private func saveStates() {
    UserDefaults.standard.set(themeButtons[0].isSelected, forKey: "classicButton")
    UserDefaults.standard.set(themeButtons[1].isSelected, forKey: "dayButton")
    UserDefaults.standard.set(themeButtons[2].isSelected, forKey: "nightButton")
  }
}
