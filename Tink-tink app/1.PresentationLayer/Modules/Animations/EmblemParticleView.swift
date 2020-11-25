//
//  EmblemParticleView.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 24.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

class EmblemParticleView: UIView {
  // main emitter layer
  var emitter: CAEmitterLayer!
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)

    if view === self {
      //startAnimation(point: point)
      return nil
    }
    return view
  }
  
  func startAnimation(point: CGPoint) {
    emitter = CAEmitterLayer()
    emitter.fillMode = .removed
    emitter.emitterPosition = point
    emitter.renderMode = .backToFront
    emitter.emitterSize = CGSize(width: frame.width / 2, height: frame.width / 3)
    emitter.emitterShape = .point
    //snowLayer.emitterZPosition = 20
    emitter.beginTime = CACurrentMediaTime()
    //    snowLayer.timeOffset = CFTimeInterval(arc4random_uniform(6) + 5)
    emitter.emitterCells = [makeEmblemCell()]
    //emitter.delegate = self
    
    layer.addSublayer(emitter)
  }
  
  func makeEmblemCell() -> CAEmitterCell {
    let cell = CAEmitterCell()
    cell.contents = UIImage(named: "emblem")?.cgImage
    cell.scale = 0.03
    cell.scaleRange = 0.3
    cell.emissionRange = .pi
    cell.lifetime = 1.2
    cell.birthRate = 15
    
    cell.velocity = 40
    cell.velocityRange = -20
    
    cell.spin = -0.5
    cell.spinRange = 1.0
    
    return cell
  }
  
  func stopAnimation() {
    emitter?.birthRate = 0
    emitter.removeFromSuperlayer()
  }
}
