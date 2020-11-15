//
//  LoaderImagesService.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol ILoaderImagesService {
  func loadImages(completion: @escaping (Result<RequestConfig<JsonParser> ,Error>) -> Void)
}

class LoaderImagesService: ILoaderImagesService {
  let networkDataFetcher: INetworkDataFetcher
  let request: IRequest
  
  init(networkDataFetcher: INetworkDataFetcher) {
    self.networkDataFetcher = networkDataFetcher
    self.request = PixbayAPIRequest()
  }
  
  func loadImages(completion: @escaping (Result<RequestConfig<JsonParser>, Error>) -> Void) {
    let requestConfig = RequestsFactory.PixbayAPIRequests.ImagesRequests.imagesConfig()
    networkDataFetcher.fetchData(from: requestConfig) {result in
      switch result {
      case .success(let response):
        DispatchQueue.main.async {
          print(response.hits.count)
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
