//
//  SBSDimentions.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import UIKit

struct SBSDimensions {
  static func topArea() -> CGFloat {
    var topSafeArea: CGFloat = 0
    
    if #available(iOS 11.0, *) {
      let window = UIApplication.shared.delegate?.window
      topSafeArea = window??.safeAreaInsets.top ?? 0
    }
    
    return topSafeArea
  }
  
  static func bottomArea() -> CGFloat {
    var bottomSafeArea: CGFloat = 0
    
    if #available(iOS 11.0, *) {
      let window = UIApplication.shared.delegate?.window
      bottomSafeArea = window??.safeAreaInsets.bottom ?? 0
    }
    return bottomSafeArea
  }
  
  static func safeArea() -> CGFloat {
    return topArea() + bottomArea()
  }
}
