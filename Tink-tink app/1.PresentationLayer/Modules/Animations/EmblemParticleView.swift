//
//  EmblemParticleView.swift
//  Tink-tink app
//
//  Created by Анастасия Леонтьева on 24.11.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

class MyWindow: UIWindow {
  // MARK: Public properties
  var didStartAnimate: ((_ point: CGPoint) -> Void)?
  var didStopAnimate: (() -> Void)?
      
  override func sendEvent(_ event: UIEvent) {
    
    if event.type == .touches {
      if let count = event.allTouches?.filter({ $0.phase == .began }).count, count > 0 {
      //  print("window found \(count) touches began")
        guard let point = event.allTouches?.first?.location(in: self) else { return }
        didStartAnimate?(point)
      }
      if let count = event.allTouches?.filter({ $0.phase == .ended }).count, count > 0 {
       // print("window found \(count) touches ended")
        
        didStopAnimate?()
      }
    }
    super.sendEvent(event)
  }
}

class EmblemParticleView: UIView {
  // MARK: CAEmitterLayer
  var emitter: CAEmitterLayer!
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)
    startAnimation(point: point)
    
    let window = self.window as? MyWindow
    
    window?.didStopAnimate = { [weak self] in
      self?.stopAnimation()
    }
        if view === self {
          return nil
        }
        return view
  }
    
  // MARK: Lifecycle
  override func layoutSubviews() {
    super.layoutSubviews()
    emitter = CAEmitterLayer()
    emitter.emitterSize = CGSize(width: self.frame.width / 2, height: self.frame.width / 3)
    emitter.fillMode = .removed
    emitter.renderMode = .backToFront
    emitter.emitterShape = .point
    layer.addSublayer(emitter)
  }
  
  // MARK: Public Methods
  func startAnimation() {
    let window = self.window as? MyWindow
    window?.didStartAnimate = { [weak self] in
      guard let self = self else {
        return
      }
      self.emitter.emitterPosition = $0
      self.emitter.beginTime = CACurrentMediaTime()
      self.emitter.emitterCells = [self.makeEmblemCell()]
    }
  }
  
  func stopAnimation() {
    let window = self.window as? MyWindow
    window?.didStopAnimate = { [weak self] in
      self?.emitter?.birthRate = 0
      self?.emitter?.removeFromSuperlayer()
    }
    self.emitter?.birthRate = 0
    self.emitter?.removeFromSuperlayer()
  }
  
  // MARK: Private Methods
  private func startAnimation(point: CGPoint) {
      self.emitter.emitterPosition = point
      self.emitter.beginTime = CACurrentMediaTime()
      self.emitter.emitterCells = [self.makeEmblemCell()]
  }
  
  private func makeEmblemCell() -> CAEmitterCell {
    let cell = CAEmitterCell()
    cell.contents = UIImage(named: "emblem")?.cgImage
    cell.scale = 0.03
    cell.scaleRange = 0.3
    cell.emissionRange = .pi
    cell.lifetime = 1
    cell.birthRate = 15
    
    cell.velocity = 60
    cell.velocityRange = -20
    
    cell.spin = -0.5
    cell.spinRange = 1.0
    
    return cell
  }
  
  // MARK: Deinit
  deinit {
    emitter?.removeFromSuperlayer()
  }
}
