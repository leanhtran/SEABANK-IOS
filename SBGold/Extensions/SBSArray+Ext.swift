//
//  SBSArray+Ext.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import Foundation

extension Array {
  func safeValue(at index: Int) -> Element? {
    if index >= 0 && index < self.count {
      return self[index]
    } else {
      return nil
    }
  }
}
