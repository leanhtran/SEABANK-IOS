//
//  SBSUtils.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import Foundation

internal func Init<T>( _ object: T, block: (T) throws -> ()) rethrows -> T {
  try block(object)
  return object
}

internal func Apply<T>( _ object: T, block: (T) throws -> ()) rethrows {
  try block(object)
}
