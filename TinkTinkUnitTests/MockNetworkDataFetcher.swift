//
//  LoaderImagesServiceMock.swift
//  TinkTinkUnitTests
//
//  Created by Анастасия Леонтьева on 30.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

final class MockNetworkDataFetcher: INetworkDataFetcher {
  
  var callsCount = 0
  var urlRequest: URLRequest!
  
  var loadDataStub: (((Result<JsonParser.Model, NetworkingError>) -> Void) -> Void)!
  
  func fetchData(from config: RequestConfig<JsonParser>, completion: @escaping (Result<JsonParser.Model, NetworkingError>) -> Void) {
    callsCount += 1
    urlRequest = config.request.urlRequest!
    loadDataStub(completion)
  }
}
