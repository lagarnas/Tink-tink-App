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
  
  var didTapThemeButton: ((UIColor) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Settings"
    self.navigationController?.navigationBar.prefersLargeTitles = false
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
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
      themeButtonTapped(classicButton)
      didTapThemeButton?(UIColor.green)
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
    switch sender{
    case classicButton:
      classicButton.isSelected = true
      nightButton.isSelected   = false
      dayButton.isSelected     = false
    case dayButton:
      dayButton.isSelected     = true
      classicButton.isSelected = false
      nightButton.isSelected   = false
    case nightButton:
      nightButton.isSelected   = true
      classicButton.isSelected = false
      dayButton.isSelected     = false
    default:
      break
    }
    
    sender.shake()
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
