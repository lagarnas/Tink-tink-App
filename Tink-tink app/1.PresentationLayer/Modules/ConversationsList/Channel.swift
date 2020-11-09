//
//  ConversationCellModel.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 28.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import Firebase

struct Channel {
    var identifier: String
    var name: String
    var lastMessage: String?
    var lastActivity: Date?
}
