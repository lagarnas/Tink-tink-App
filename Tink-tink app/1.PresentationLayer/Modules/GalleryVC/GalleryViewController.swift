//
//  GalleryViewController.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 13.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
  
  var galleryModel: IGalleryModel?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      galleryModel?.loadImages()
    }

}
