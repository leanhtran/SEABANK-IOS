//
//  SBBuyGoldVC.swift
//  SBGold
//
//  Created by Anonymos on 07/06/2021.
//

import UIKit

class SBBuyGoldVC: SBSGoldBaseVC {
  @IBOutlet weak private var containerView: UIView!
  @IBOutlet weak private var accountLb: UILabel!
  @IBOutlet weak private var moneyLb: UILabel!
  
  @IBOutlet weak private var warningLb: UILabel!
  @IBOutlet weak private var transactionPlaceLb: UILabel!
  
  @IBOutlet weak private var cityView: InputTextView!
  @IBOutlet weak private var districtView: InputTextView!
  @IBOutlet weak private var transactionPlaceView: InputTextView!
  
  @IBOutlet weak private var goldTypeView: SBSInfoView!
  @IBOutlet weak private var quantityView: SBSNumberView!
  @IBOutlet weak private var priceView: SBSInfoView!
  @IBOutlet weak private var amountView: SBSInfoView!
  
  @IBOutlet weak var deliveryFormView: InputTextView!
  
  @IBOutlet weak var goldImmediatelyView: CheckBoxView!
  
  @IBOutlet weak var transactionTypeView: InputTextView!
  
  @IBOutlet weak var promotionView: InputTextView!
  
  
  private var priceUnit: Int = 0 {
    didSet {
      priceView.setContent(priceUnit.withCommas() + " VNĐ")
    }
  }
  private var quantity: Int = 0 {
    didSet {
      amountView.setContent((priceUnit * quantity).withCommas() + " VNĐ")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    priceUnit = 5500000
    quantity = 1
  }
  
  override func setupView() {
    containerView.backgroundColor = bgColor
    setupMultiLanguage()
    setupNavigation()
    setupValueChange()
  }
  
  private func setupNavigation() {
    addNavigation(title: Text.localizedString("BuyGod.NaviTitle"))
    navigationView.setRightIcon("ic_info")
    cityView.title = Text.localizedString("BuyGod.SelectCity")
    districtView.title = Text.localizedString("BuyGod.SelectDistrict")
    transactionPlaceView.title = Text.localizedString("BuyGod.SelectTransactionPlace")
    quantityView.setTitle(Text.localizedString("BuyGod.Quantity"))
    priceView.setTitle(Text.localizedString("BuyGod.Price"))
    amountView.setTitle(Text.localizedString("BuyGod.Amount"))
    Apply(goldTypeView!) {
      $0.setTitle(Text.localizedString("BuyGod.GoldType"))
      $0.setContent(Text.localizedString("BuyGod.SJCGold"))
    }
  }
  
  override func naviRightAction() {
    // todo right action
  }
  
  private func setupMultiLanguage() {
    warningLb.text = Text.localizedString("BuyGod.Warning")
    transactionPlaceLb.text = Text.localizedString("BuyGod.TransactionPlace")
  }
  
  private func setupValueChange() {
    quantityView.onValueChange = { [weak self] value in
      self?.quantity = value
    }
  }
}
