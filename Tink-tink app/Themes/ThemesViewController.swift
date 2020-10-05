//
//  ThemesViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 02.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
  
  @IBOutlet private weak var classicButton: ThemeButton!
  @IBOutlet private weak var dayButton: ThemeButton!
  @IBOutlet private weak var nightButton: ThemeButton!
  
  @IBOutlet private weak var classicLabel: UILabel!
  @IBOutlet private weak var dayLabel: UILabel!
  @IBOutlet private weak var nightLabel: UILabel!
  
  var didChangeThemeButton: ((Themeable) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Settings"
    self.navigationController?.navigationBar.prefersLargeTitles = false
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
    setupLabelTapRecognizer(label: classicLabel)
    setupLabelTapRecognizer(label: dayLabel)
    setupLabelTapRecognizer(label: nightLabel)
    
    applyTheme()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()

  }
  
  private func applyTheme() {
    view.backgroundColor = Theme.current.background
    classicLabel.textColor = Theme.current.mainTextColor
    dayLabel.textColor = Theme.current.mainTextColor
    nightLabel.textColor = Theme.current.mainTextColor
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
      themeButtonTapped(classicButton)
    case dayLabel:
      themeButtonTapped(dayButton)
    case nightLabel:
      themeButtonTapped(nightButton)
    default:
      break
    }
  }
  
  @IBAction
  private func themeButtonTapped(_ sender: ThemeButton) {
    sender.isSelected = !sender.isSelected
    switch sender {
    case classicButton:
      nightButton.isSelected   = false
      dayButton.isSelected     = false
      didChangeThemeButton?(ClassicTheme())
    case dayButton:
      classicButton.isSelected = false
      nightButton.isSelected   = false
      didChangeThemeButton?(DayTheme())
    case nightButton:
      classicButton.isSelected = false
      dayButton.isSelected     = false
      didChangeThemeButton?(NightTheme())
    default:
      break
    }
    
    
    sender.shake()
    applyTheme()
  }
  
  
  @objc private func dismissVC() {
    self.navigationController?.popViewController(animated: true)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
