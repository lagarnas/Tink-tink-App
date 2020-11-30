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
  
  func testExample() throws {
    // Arrange
    let hits = [Hit(previewURL: ""),
                Hit(previewURL: ""),
                Hit(previewURL: ""),
                Hit(previewURL: ""),
                Hit(previewURL: "")
    ]
    
    let loaderImageServiceMock = LoaderImagesServiceMock()
    loaderImageServiceMock.loadImagesStub = { completion in
      completion(.success(hits))
    }
    // Act
    let galleryModel = GalleryModel(loaderImagesService: loaderImageServiceMock)
    galleryModel.fetchGallery()
    
    // Asserts
    XCTAssertEqual(loaderImageServiceMock.callsCount, 1)
    
  }
  
}
