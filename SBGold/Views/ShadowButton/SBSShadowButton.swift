//
//  SBSShadowButton.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit

final class SBSShadowButton: UIButton {
  var shadowColor: UIColor = .black {
    didSet {
      self.layer.shadowColor = shadowColor.cgColor
    }
  }
  var corners: UIRectCorner = .allCorners {
    didSet {
      setupShadow()
    }
  }
  var offset: CGPoint = .zero {
    didSet {
      setupShadow()
    }
  }
  override var cornerRadius: CGFloat {
    didSet {
      setupShadow()
    }
  }
  
  public func setupShadow() {
    self.layer.cornerRadius = max(5, cornerRadius)
    self.layer.shadowOffset = CGSize(width: 0, height: 2)
    self.layer.shadowRadius = 2
    self.layer.shadowOpacity = 0.1
    self.layer.shadowColor = shadowColor.cgColor
    self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: -offset.x, y: -offset.y,
                                                             width: bounds.width + offset.x,
                                                             height: bounds.height + offset.y),
                                         byRoundingCorners: corners,
                                         cornerRadii: CGSize(width: 5, height: 5)).cgPath
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = UIScreen.main.scale
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupShadow()
  }
}
