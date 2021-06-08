//
//  SBSGoldInfoFooter.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit

final class SBSGoldInfoFooter: ViewWithXib {
  @IBOutlet weak private var contentLb: UILabel!
  @IBOutlet weak private var titleLb: UILabel!
  
  override func setupView() {
    contentLb.text = ""
    titleLb.text = ""
  }
  
  func setTitle(text: String) {
    titleLb.text = text
  }
  
  func setContent(text: String) {
    contentLb.text = text
  }
}
