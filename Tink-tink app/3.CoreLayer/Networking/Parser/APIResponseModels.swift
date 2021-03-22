//
//  APIResponseModels.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 30.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct Empty: Codable {
  let totalHits: Int
  let hits: [Hit]
}

// MARK: - Hit
public struct Hit: Codable, Equatable {
  let previewURL: String
}
