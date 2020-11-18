//
//  MessageCellModel.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 29.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct Message: Hashable {
    let senderId: String
    var senderName: String
    var content: String
    var created: Date
}