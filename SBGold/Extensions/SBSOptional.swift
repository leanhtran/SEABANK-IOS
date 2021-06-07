//
//  SBSOptional.swift
//  SBGold
//
//  Created by Anonymos on 07/06/2021.
//

import Foundation

extension Optional {
  func stringValue() -> String {
    switch(self) {
    case .none:
      return ""
    case .some(let value):
      return value as? String ?? ""
    }
  }
  
  func intValue() -> Int {
    switch(self) {
    case .none:
      return 0
    case .some(let value):
      return value as? Int ?? 0
    }
  }
  
  func floatValue() -> Float {
    switch(self) {
    case .none:
      return 0
    case .some(let value):
      return value as? Float ?? 0
    }
  }
  
  func doubleValue() -> Double {
    switch(self) {
    case .none:
      return 0
    case .some(let value):
      return value as? Double ?? 0
    }
  }
  
  func boolValue() -> Bool {
    switch(self) {
    case .none:
      return false
    case .some(let value):
      return value as? Bool ?? false
    }
  }
  
  func int64Value() -> Int64 {
    switch(self) {
    case .none:
      return 0
    case .some(let value):
      return value as? Int64 ?? 0
    }
  }
  
  func arrayValue<T>(_ aClass: T.Type) -> [T] {
    switch(self) {
    case .none:
      return []
    case .some(let value):
      return value as? [T] ?? []
    }
  }
  
  func value<T>(defaultValue: T) -> T {
    switch(self) {
    case .none:
      return defaultValue
    case .some(let value):
      return value as? T ?? defaultValue
    }
  }
}
