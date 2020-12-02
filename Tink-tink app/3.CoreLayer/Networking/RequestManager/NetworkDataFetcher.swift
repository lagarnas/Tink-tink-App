//
//  NetworkDataFetcher.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 15.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol INetworkDataFetcher {
  func fetchData(from config: RequestConfig<JsonParser>,
                 completion: @escaping (Result <JsonParser.Model,
                                                NetworkingError>) -> Void)
}

class NetworkDataFetcher: INetworkDataFetcher {
  
  func fetchData(from config: RequestConfig<JsonParser>,
                 completion: @escaping (Result <JsonParser.Model,
                                                NetworkingError>) -> Void) {
    config.sender.send(request: config) { result in
      switch result {
      case .success(let data):
        guard let response: JsonParser.Model = config.parser.parse(data: data)
        else { return }
        completion(.success(response))
        
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
