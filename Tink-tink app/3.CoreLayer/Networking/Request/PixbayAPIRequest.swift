//
//  PixbayAPIRequest.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct API {
  static let scheme = "https"
  static let host = "pixabay.com"
  static let path = "/api/"
  
  static let apiKey = "19096059-7cc78a27f3e51a7e4cf696f0d"
  
  enum QueryItemName: String {
    case imageType = "image_type"
    case q = "q"
    case key = "key"
    case perPage = "per_page"
  }
}

protocol IPixbayAPIRequest {
  var urlRequest: URLRequest? { get }
}

class PixbayAPIRequest: IPixbayAPIRequest {
  
  var urlRequest: URLRequest? {
    let url = urlPath([URLQueryItem(name: API.QueryItemName.q.rawValue,
                                    value: "yellow+flowers"),
                       URLQueryItem(name: API.QueryItemName.imageType.rawValue,
                                    value: "photo"),
                       URLQueryItem(name: API.QueryItemName.perPage.rawValue,
                                    value: "20")])
    guard let urlPath = url else { return nil }
    print(urlPath)
    return URLRequest(url: urlPath)
    
  }
  
  private func urlPath( _ queryItems: [URLQueryItem]) -> URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = API.scheme
    urlComponents.host = API.host
    urlComponents.path = API.path
    urlComponents.queryItems = queryItems + [URLQueryItem(name: API.QueryItemName.key.rawValue, value: API.apiKey)]
    
    return urlComponents.url
  }
}
