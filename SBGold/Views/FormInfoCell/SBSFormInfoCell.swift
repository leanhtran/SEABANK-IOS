//
//  SBSFormInfoCell.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit

class SBSFormInfoCell: SBSGoldTableViewCell {
  @IBOutlet weak private var titlelb: UILabel!
  @IBOutlet weak private var contentLb: UILabel!
  
  func setTitle(_ text: String) {
    titlelb.text = text
  }
  
  func bindData(_ text: String) {
    contentLb.text = text
  }
}
