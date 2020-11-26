//
//  EmblemParticleView.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 24.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

//extension UIView {
//  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    print(self, #function)
//    next?.touchesBegan(touches, with: event)
//  }
//}

class EmblemParticleView: UIView {
  // main emitter layer
  var emitter: CAEmitterLayer!
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)
    print(point)
     startAnimation(point: point)
    if view === self {
      return nil
    }
    return view
  }
    
  override func layoutSubviews() {
    super.layoutSubviews()
    emitter = CAEmitterLayer()
    layer.addSublayer(emitter)
  }
  
  func startAnimation(point: CGPoint) {

    emitter.fillMode = .removed
    emitter.emitterPosition = point
    emitter.fillMode = .removed
    emitter.renderMode = .backToFront
    emitter.emitterSize = CGSize(width: frame.width / 2, height: frame.width / 3)
    emitter.emitterShape = .point
    emitter.beginTime = CACurrentMediaTime()
    emitter.emitterCells = [makeEmblemCell()]

  }
  
  func makeEmblemCell() -> CAEmitterCell {
    let cell = CAEmitterCell()
    cell.contents = UIImage(named: "emblem")?.cgImage
    cell.scale = 0.03
    cell.scaleRange = 0.3
    cell.emissionRange = .pi
    cell.lifetime = 1
    cell.birthRate = 10
    
    cell.velocity = 40
    cell.velocityRange = -20
    
    cell.spin = -0.5
    cell.spinRange = 1.0
    
    return cell
  }
  
  func stopAnimation() {
    emitter?.birthRate = 0
    emitter?.removeFromSuperlayer()
  }
  
  deinit {
    print("deinit")
    emitter?.removeFromSuperlayer()
  }
}
