//
//  Date + Extension.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 29.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

extension Date {
  
  func getFormattingDate() -> String {
    let formatterForToday = DateFormatter()
    let formatterForPastDays = DateFormatter()
    formatterForToday.dateFormat = "HH:mm"
    formatterForPastDays.dateFormat = "dd MMM"
    
    let calendar = Calendar.current
    if calendar.isDateInToday(self){
      return formatterForToday.string(from: self)
    } else {
      return formatterForPastDays.string(from: self)
    }
  }
}
