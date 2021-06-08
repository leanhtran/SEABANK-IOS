//
//  SBGoldWithdrawConfirmVC.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit

class SBGoldWithdrawConfirmVC: SBSGodWithdrawVC {
  @IBOutlet weak private var placeLb: UILabel!
  @IBOutlet weak private var dateLb: UILabel!
  @IBOutlet weak private var feeLb: UILabel!
  @IBOutlet weak private var feeInfoLb: UILabel!
  @IBOutlet weak private var placeValueLb: UILabel!
  @IBOutlet weak private var dateValueLb: UILabel!
  @IBOutlet weak private var feeValueLb: UILabel!
  @IBOutlet weak private var nextBtn: UIButton!
  
  override func setupView() {
    setupMultiLanguage()
  }
  
  private func setupMultiLanguage() {
    placeLb.text = Text.localizedString("")
  }
}
