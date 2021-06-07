//
//  SBSVerifyBuyInfoVC.swift
//  SBGold
//
//  Created by Anonymos on 2021/06/07.
//

import UIKit

class SBSVerifyBuyInfoVC: SBSGoldBaseVC {
  @IBOutlet weak private var acountLb: UILabel!
  @IBOutlet weak private var fullNameLb: UILabel!
  @IBOutlet weak private var placeLb: UILabel!
  @IBOutlet weak private var goldTypeLb: UILabel!
  @IBOutlet weak private var quantityLb: UILabel!
  @IBOutlet weak private var priceLb: UILabel!
  @IBOutlet weak private var amountLb: UILabel!
  @IBOutlet weak private var deleveryLb: UILabel!
  @IBOutlet weak private var appointmentDateLb: UILabel!
  @IBOutlet weak private var transactionClassifyLb: UILabel!
  @IBOutlet weak private var promotionLb: UILabel!
  @IBOutlet weak private var referUserLb: UILabel!
  @IBOutlet weak private var transactionDateLb: UILabel!
  
  @IBOutlet weak private var acountValueLb: UILabel!
  @IBOutlet weak private var fullNameValueLb: UILabel!
  @IBOutlet weak private var placeValueLb: UILabel!
  @IBOutlet weak private var goldTypeValueLb: UILabel!
  @IBOutlet weak private var quantityValueLb: UILabel!
  @IBOutlet weak private var priceValueLb: UILabel!
  @IBOutlet weak private var amountValueLb: UILabel!
  @IBOutlet weak private var deleveryValueLb: UILabel!
  @IBOutlet weak private var appointmentDateValueLb: UILabel!
  @IBOutlet weak private var transactionClassifyValueLb: UILabel!
  @IBOutlet weak private var promotionValueLb: UILabel!
  @IBOutlet weak private var referUserValueLb: UILabel!
  @IBOutlet weak private var transactionDateValueLb: UILabel!
  
  @IBOutlet weak private var nextBtn: UIButton!
  override func setupView() {
    addNavigation(title: Text.localizedString("BGVI.NaviTitle"))
    setupMultiLanguage()
    setupCommon()
  }
  
  private func setupCommon() {
    addObservable(buttons: [nextBtn])
  }
  
  override func didTapButton(_ btn: UIButton) {
    
  }
  
  private func setupMultiLanguage() {
    acountLb.text = Text.localizedString("BGVI.Account")
    fullNameLb.text = Text.localizedString("BGVI.FullName")
    placeLb.text = Text.localizedString("BGVI.TransactionPlace")
    goldTypeLb.text = Text.localizedString("BGVI.GoldType")
    quantityLb.text = Text.localizedString("BGVI.Quantity")
    priceLb.text = Text.localizedString("BGVI.Price")
    amountLb.text = Text.localizedString("BGVI.Amount")
    deleveryLb.text = Text.localizedString("BGVI.DeleveryForm")
    appointmentDateLb.text = Text.localizedString("BGVI.AppointmentDate")
    transactionClassifyLb.text = Text.localizedString("BGVI.TransactionClassify")
    promotionLb.text = Text.localizedString("BGVI.PromotionCode")
    referUserLb.text = Text.localizedString("BGVI.ReferUserInfo")
    transactionDateLb.text = Text.localizedString("BGVI.TransactionDate")
    nextBtn.setTitle(Text.localizedString("Button.Continue"), for: .normal)
  }
  
}
