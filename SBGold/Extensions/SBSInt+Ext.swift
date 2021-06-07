//
//  SBSInt+Ext.swift
//  SBGold
//
//  Created by Anonymos on 07/06/2021.
//

import Foundation

extension Int {
  func withCommas() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.groupingSeparator = ","
    return numberFormatter.string(from: NSNumber(value:self)) ?? ""
  }
  
  func toString() -> String {
    return "\(self)"
  }
  
  func toShortString() -> String {
    switch self {
    case _ where self < 10000 :
      return self.toString()
    case _ where self < 1000000:
      let value = self / 1000
      let offset = (self - value * 1000) / 100
      let result = offset == 0 ? value.toString() : value.toString() + "." + offset.toString()
      return result + "K"
    default:
      let value = self / 1000000
      let offset = (self - value * 1000000) / 1000
      let result = offset == 0 ? value.toString() : value.toString() + "." + offset.toString()
      return result + "M"
    }
  }
  
  func toDecimaString() -> String {
    return self < 10 ? "0\(self)" : "\(self)"
  }
}

extension Int64 {
  func toString() -> String {
    return "\(self)"
  }
}
