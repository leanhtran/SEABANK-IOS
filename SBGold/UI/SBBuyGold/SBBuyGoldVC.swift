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
  
  @IBOutlet weak private var appointmentDateView: SBSInfoView!
  @IBOutlet weak private var deliveryFormView: InputTextView!
  @IBOutlet weak private var goldImmediatelyView: SBSCheckBoxView!
  @IBOutlet weak private var transactionTypeView: InputTextView!
  @IBOutlet weak private var promotionView: InputTextView!
  
  @IBOutlet weak private var referUserRadioView: SBSRadioView!
  
  
  
  @IBOutlet weak private var transactionDateView: SBSInfoView!
  @IBOutlet weak private var policyView: SBSCheckBoxView!
  
  
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
    appointmentDateView.setContent(Date().toString(format: "yyyy/MM/dd"))
    transactionDateView.setContent(Date().toString(format: "yyyy/MM/dd"))
  }
  
  override func setupView() {
    containerView.backgroundColor = bgColor
    setupMultiLanguage()
    setupNavigation()
    setupValueChange()
    setupCommon()
  }
  
  private func setupNavigation() {
    addNavigation(title: Text.localizedString("BuyGod.NaviTitle"))
    navigationView.setRightIcon("ic_info")
  }
  
  override func naviRightAction() {
    // todo right action
  }
  
  private func setupCommon() {
    Apply(referUserRadioView!) {
      $0.layer.borderWidth = 1
      $0.layer.borderColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
      $0.clipsToBounds = true
      $0.layer.cornerRadius = 5
    }
  }
  
  private func setupMultiLanguage() {
    warningLb.text = Text.localizedString("BuyGod.Warning")
    transactionPlaceLb.text = Text.localizedString("BuyGod.TransactionPlace")
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
    Apply(appointmentDateView!) {
      $0.setTitle(Text.localizedString("BuyGod.AppointmentDate"))
      $0.titleColor = #colorLiteral(red: 0.5725490196, green: 0.5803921569, blue: 0.5921568627, alpha: 1)
      $0.contentFont = UIFont.boldSystemFont(ofSize: 14)
    }
    deliveryFormView.title = Text.localizedString("BuyGod.DeleveryForm")
    Apply(goldImmediatelyView!) {
      $0.setTitle(Text.localizedString("BuyGod.ReceiveImmediately"))
      $0.setMessage(Text.localizedString("BuyGod.ContactNotice"))
    }
    transactionTypeView.title = Text.localizedString("BuyGod.TransactionClassify")
    promotionView.title = Text.localizedString("BuyGod.PromotionCode")
    referUserRadioView.setRadioTitle([
      Text.localizedString("BuyGod.Phone"),
      Text.localizedString("BuyGod.CustomerCode")
    ])
    Apply(transactionDateView!) {
      $0.setTitle(Text.localizedString("BuyGod.TransactionDate"))
      $0.titleColor = #colorLiteral(red: 0.5725490196, green: 0.5803921569, blue: 0.5921568627, alpha: 1)
      $0.contentFont = UIFont.boldSystemFont(ofSize: 14)
    }
    Apply(policyView!) {
      $0.setTitle(Text.localizedString("BuyGod.BuyGod.Policy"))
      $0.setMessage("")
    }
  }
  
  private func setupValueChange() {
    quantityView.onValueChange = { [weak self] value in
      self?.quantity = value
    }
  }
}

//"BuyGod.ReferUserInfo" = "Thông tin người giới thiệu (nếu có)";
//"BuyGod.Phone" = "Số điện thoại";
//"BuyGod.CustomerCode" = "Mã khách hàng";
//"BuyGod.ReferUserPhone" = "Nhập số điện thoại người giới thiệu";
//"BuyGod.TransactionDate" = "Ngày giao dịch";
