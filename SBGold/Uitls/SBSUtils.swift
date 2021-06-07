//
//  SBSUtils.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import UIKit

let mainColor = #colorLiteral(red: 0.8431372549, green: 0.09803921569, blue: 0.1254901961, alpha: 1)
let bgColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9803921569, alpha: 1)

internal func Init<T>( _ object: T, block: (T) throws -> ()) rethrows -> T {
  try block(object)
  return object
}

internal func Apply<T>( _ object: T, block: (T) throws -> ()) rethrows {
  try block(object)
}
