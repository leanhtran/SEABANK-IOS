//
//  SBGoldWithdrawConfirmVC.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit

class SBGoldWithdrawConfirmVC: SBSGoldBaseVC {
  @IBOutlet weak private var placeLb: UILabel!
  @IBOutlet weak private var dateLb: UILabel!
  @IBOutlet weak private var feeLb: UILabel!
  @IBOutlet weak private var feeInfoLb: UILabel!
  @IBOutlet weak private var placeValueLb: UILabel!
  @IBOutlet weak private var dateValueLb: UILabel!
  @IBOutlet weak private var feeValueLb: UILabel!
  @IBOutlet weak private var nextBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    placeValueLb.text = "PGD Vạn Xuân - 38 Yết Kiêu - Hoàn Kiếm"
    dateValueLb.text = "13/3/2023"
    feeValueLb.text = "100,000 VND"
  }
  
  override func setupView() {
    setupMultiLanguage()
    setupCommon()
  }
  
  private func setupCommon() {
    addObservable(buttons: [nextBtn])
    addNavigation(title: Text.localizedString("GoldWithdraw.Confirm"))
    view.backgroundColor = bgColor
  }
  
  private func setupMultiLanguage() {
    placeLb.text = Text.localizedString("GoldWithdraw.Place")
    dateLb.text = Text.localizedString("GoldWithdraw.WithdrawDate")
    feeLb.text = Text.localizedString("GoldWithdraw.WithdrawFee")
    feeInfoLb.text = Text.localizedString("GoldWithdraw.WithdrawInfo")
    nextBtn.setTitle(Text.localizedString("Button.Continue"), for: .normal)
  }
  
  override func didTapButton(_ btn: UIButton) {
    SBSCoordinator.shared.moveTo(Route.withdrawSuccess)
  }
}
