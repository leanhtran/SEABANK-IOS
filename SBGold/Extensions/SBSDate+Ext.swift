//
//  SBSDate+Ext.swift
//  SBGold
//
//  Created by Anonymos on 2021/06/07.
//

import Foundation

extension Date {
  func toString(format: String, isUTC: Bool = false) -> String {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = format
    if isUTC {
      dateFormat.timeZone = TimeZone(abbreviation: "UTC")
    }
    return dateFormat.string(from: self)
  }
  
  func toISO8601String(isUTC: Bool = false) -> String {
    let isoFormatter = ISO8601DateFormatter()
    if !isUTC {
      isoFormatter.timeZone = TimeZone.current
    }
    isoFormatter.formatOptions = [.withInternetDateTime,
                                  .withFractionalSeconds,
                                  .withDashSeparatorInDate,
                                  .withColonSeparatorInTime,
                                  .withColonSeparatorInTimeZone,
                                  .withFullTime,
                                  .withFullDate]
    return isoFormatter.string(from: self)
  }
  
}
