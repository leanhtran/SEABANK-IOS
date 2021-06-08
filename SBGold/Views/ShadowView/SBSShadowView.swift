//
//  ShadowView.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//
import UIKit

final class SBSShadowView: UIView {
  var shadowColor: UIColor = .black {
    didSet {
      self.layer.shadowColor = shadowColor.cgColor
    }
  }
  var shadowOpacity: Float = 0.1 {
    didSet {
      self.layer.shadowOpacity = shadowOpacity
    }
  }
  
  var corners: UIRectCorner? = .allCorners {
    didSet {
      setupShadow()
    }
  }
  var offset: CGPoint = .zero {
    didSet {
      setupShadow()
    }
  }
  
  public func setupShadow() {
    if let corners = corners {
      layer.shadowOffset = CGSize(width: 0, height: 2)
      layer.shadowRadius = 2
      layer.shadowOpacity = shadowOpacity
      layer.shadowColor = shadowColor.cgColor
      if corners == .allCorners {
        layer.cornerRadius = 5
      } else {
        roundingCorners(radius: 5, corners: corners)
      }
      layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: -offset.x, y: -offset.y,
                                                          width: bounds.width + offset.x,
                                                          height: bounds.height + offset.y),
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: 5, height: 5)).cgPath
    } else {
      layer.shadowPath = nil
      layer.cornerRadius = 0
      layer.shadowColor = UIColor.clear.cgColor
    }
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupShadow()
  }
}
