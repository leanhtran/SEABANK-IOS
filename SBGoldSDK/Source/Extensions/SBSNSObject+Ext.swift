//
//  NSObject+Ext.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import Foundation

extension NSObject {
  class var className: String {
    return String(describing: self).components(separatedBy: ".").last!
  }
  var className: String {
    return String(describing: type(of: self)).components(separatedBy: ".").last!
  }
}
