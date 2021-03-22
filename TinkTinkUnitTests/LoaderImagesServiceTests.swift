//
//  TinkTinkUnitTests.swift
//  TinkTinkUnitTests
//
//  Created by Анастасия Леонтьева on 30.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import XCTest
@testable import Tink_tink_app

class LoaderImagesServiceTests: XCTestCase {
  
  func testRequestConfig() throws {
    // Arrange
    let testHits = [Hit(previewURL: ""),
                Hit(previewURL: ""),
                Hit(previewURL: ""),
                Hit(previewURL: ""),
                Hit(previewURL: "")
    ]
    
    var returnedTestHits = [Hit]()
    let empty = Empty(totalHits: testHits.count, hits: testHits)
    let url = URL(string: "https://pixabay.com/api/?q=yellow+flowers&image_type=photo&per_page=100&key=19096059-7cc78a27f3e51a7e4cf696f0d")!
    
    let networkDataFetcherMock = MockNetworkDataFetcher()
    networkDataFetcherMock.loadDataStub = { completion in
      completion(.success(empty))
    }
    // Act
    let loaderImagesService = LoaderImagesService(networkDataFetcher: networkDataFetcherMock)
    
    loaderImagesService.loadImages { result in
      switch result {
      case .success(let hits):
        returnedTestHits.append(contentsOf: hits)
      case .failure(_):
        break
      }
    }
    
    // Asserts
    XCTAssertEqual(returnedTestHits, testHits)
    XCTAssertEqual(networkDataFetcherMock.callsCount, 1)
    XCTAssertEqual(networkDataFetcherMock.urlRequest.url, url)
    XCTAssertEqual(networkDataFetcherMock.urlRequest.httpMethod, "GET")
  }
  
    func testInvalidRequest() throws {
  
      // Arrange
      let error: NetworkingError = .invalideRequest
      var returnedError: NetworkingError?
      let networkDataFetcherMock = MockNetworkDataFetcher()
      networkDataFetcherMock.loadDataStub = { completion in
        completion(.failure(error))
      }
  
      //Act
      let loaderImagesService = LoaderImagesService(networkDataFetcher: networkDataFetcherMock)
  
      loaderImagesService.loadImages { result in
        switch result {
        case .success(_): break
        case .failure(let error):
          returnedError = error
        }
      }
  
      // Asserts
      XCTAssertEqual(returnedError, error)
    }
  
  func testInternetConnectionFailed() throws {
    
    // Arrange
    let error: NetworkingError = .internetConnectionFail
    var returnedError: NetworkingError?
    
    let networkDataFetcherMock = MockNetworkDataFetcher()
    networkDataFetcherMock.loadDataStub = { completion in
      completion(.failure(error))
    }
    
    //Act
    let loaderImagesService = LoaderImagesService(networkDataFetcher: networkDataFetcherMock)

    loaderImagesService.loadImages { result in
      switch result {
      case .success(_): break
      case .failure(let error):
       returnedError = error
      }
    }
    
    // Asserts
    XCTAssertEqual(returnedError, error)
    
  }
}
