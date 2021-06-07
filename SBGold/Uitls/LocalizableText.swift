//
//  LocalizableText.swift
//  SBGold
//
//  Created by Anonymos on 07/06/2021.
//

import Foundation

typealias Text = LocalizableText

struct LocalizableText {
  static func localizedString(_ text: String) -> String {
    return NSLocalizedString(text, comment: "")
  }
}
