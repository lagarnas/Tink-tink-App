//
//  ProfileVC + UITextField.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 10.10.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

extension ProfileViewController: UITextFieldDelegate {
  
  //решает можно ли начать редактировать поле
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    nameTextField = textField
    lastOffset = self.scrollView.contentOffset
    return true
  }
  
  //решает убрать клавиатуру или нет
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == nameTextField {
      self.nameTextField.resignFirstResponder()
      self.nameTextField = nil
    }
    return true
  }
}

extension ProfileViewController: UITextViewDelegate {
  
  //решает можно ли начать редактировать поле
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    bioTextView = textView
    lastOffset = self.scrollView.contentOffset
    return true
  }
  //решает убрать клавиатуру или нет
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      if(text == "\n") {
          textView.resignFirstResponder()
          return false
      }
      return true
  }
}

extension ProfileViewController {
  
  func addNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(notification:)), name: UITextField.textDidChangeNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(notification:)), name: UITextView.textDidChangeNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnTextView(gesture:))))
  }
  
  //MARK: - Notifications
  @objc func textDidChange(notification: Notification) {
    enabledButtons()
  }
  
  
  @objc
  func keyboardWillShow(notification: NSNotification) {
    guard keyboardHeight == nil else { return }
    
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      
      keyboardHeight = keyboardSize.height
      
      UIView.animate(withDuration: 0.3, animations: {
        self.constraintContentHeight.constant += self.keyboardHeight
      })

      // move if keyboard hide input field
      let distanceToBottom = self.scrollView.frame.size.height -
        (textStackView?.frame.origin.y)! -
        (textStackView?.frame.size.height)!
      let collapseSpace = keyboardHeight - distanceToBottom
      if collapseSpace < 0 { return }
      UIView.animate(withDuration: 0.3, animations: {
        self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
      })
    }
  }
  
  @objc
  func keyboardWillHide(notification: NSNotification) {
    UIView.animate(withDuration: 0.3) {
      guard self.keyboardHeight != nil else { return }
      self.constraintContentHeight.constant -= self.keyboardHeight
      
      self.scrollView.contentOffset = self.lastOffset
    }
    
    keyboardHeight = nil
  }
  
  @objc
  func returnTextView(gesture: UIGestureRecognizer) {
    guard nameTextField != nil, bioTextView != nil
    else {
      nameTextField = nil
      bioTextView = nil
      return
    }
    nameTextField.resignFirstResponder()
    bioTextView.resignFirstResponder()
  }
}
