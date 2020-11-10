//
//  RootAssembly.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 09.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

class RootAssembly {
  lazy var presentationAssembly: IPresentationAssembly = PresentationAssembly(serviceAssembly: self.serviceAssembly)
  private lazy var serviceAssembly: IServiceAssembly = ServiceAssembly(coreAssembly: self.coreAssembly)
  private lazy var coreAssembly: ICoreAssembly = CoreAssembly()
}
