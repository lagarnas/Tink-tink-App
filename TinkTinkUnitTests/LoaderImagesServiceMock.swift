//
//  LoaderImagesServiceMock.swift
//  TinkTinkUnitTests
//
//  Created by Анастасия Леонтьева on 30.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

final class LoaderImagesServiceMock: ILoaderImagesService {
  
  var callsCount = 0
  
  var loadImagesStub: (((Result<[Hit], Error>) -> Void) -> Void)!
  
  func loadImages(completion: @escaping (Result<[Hit], Error>) -> Void) {
    callsCount += 1
    loadImagesStub(completion)
  }
    
}
