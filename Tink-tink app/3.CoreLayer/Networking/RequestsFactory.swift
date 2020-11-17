//
//  RequestsFactory.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct RequestsFactory {
  
  struct PixbayAPIRequests {
    
    struct ImagesRequests {
      static func imagesConfig() -> RequestConfig<JsonParser> {
        let request = PixbayAPIRequest()
          let sender = RequestSender()
          
          return RequestConfig<JsonParser>(request: request, sender: sender, parser: JsonParser())
        }
    }
  }
}
