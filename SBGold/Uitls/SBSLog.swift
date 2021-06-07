//
//  SBSLog.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import Foundation

var SBSLogEnable: Bool = true

struct SBSLog {
  static func debug(message: String, function: String = #function) {
    guard SBSLogEnable else { return }
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    let date = formatter.string(from: NSDate() as Date)
    print("\(date) Func: \(function) : \(message)")
  }
}
