//
//  Parser.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct Empty: Codable {
  let total: Int
  let totalHits: Int
  let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
  let id: Int
  let previewURL: String
}

protocol IParser {
  associatedtype Model
  func parse(data: Data) -> Model?
 // func parse<Response: Decodable>(data: Data, type: Response.Type) -> Response?
}

class JsonParser: IParser {
  
  typealias Model = Empty
    
  private let decoder = JSONDecoder()
    
  func parse(data: Data) -> Model? {
    do {      
      let response = try decoder.decode(Model.self, from: data)      
      return response
    } catch let error {
      print(error.localizedDescription)
      return nil
    }
  }
}
