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
  
  @IBOutlet weak private var dueDateLb: UILabel!
  @IBOutlet weak private var dueDateView: UIView!
  @IBOutlet weak private var dueDateTf: UITextField!
  @IBOutlet weak private var periodView: SBSInfoView!
  @IBOutlet weak private var storageFeeView: SBSInfoView!
  @IBOutlet weak private var storageWithTermView: UIView!
  @IBOutlet weak private var storageWithTermHeight: NSLayoutConstraint!
  
  @IBOutlet weak private var transactionTypeView: InputTextView!
  @IBOutlet weak private var promotionView: InputTextView!
  
  @IBOutlet weak private var referUserRadioView: SBSRadioView!
  @IBOutlet weak private var transactionDateView: SBSInfoView!
  @IBOutlet weak private var policyView: SBSCheckBoxView!
  
  @IBOutlet weak private var referUserView: UIView!
  @IBOutlet weak private var continueBtn: UIButton!
  @IBOutlet weak private var referUserTf: UITextField!
  
  @IBOutlet weak private var immediatelyHeight: NSLayoutConstraint!
  
  enum DeliveryType: CaseIterable {
    case appointment
    case storageWithTerm
    case storageWithoutTerm
    
    var title: String {
      switch self {
      case .appointment:
        return Text.localizedString("BuyGod.DeliveryType.Appointment")
      case .storageWithTerm:
        return Text.localizedString("BuyGod.DeliveryType.StorageWithTerm")
      case .storageWithoutTerm:
        return Text.localizedString("BuyGod.DeliveryType.StorageWithoutTerm")
      }
    }
  }
  
  let picker = SBSPickerView()
  let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
  
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
  private var deliveryType: DeliveryType = .appointment {
    didSet {
      updateDeliveryUI()
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
    setupMultiLanguage()
    setupNavigation()
    setupValueChange()
    setupPickerView()
    setupDatePicker()
    setupCommon()
    addObservable(buttons: [continueBtn])
  }
  
  override func didTapButton(_ btn: UIButton) {
    SBSCoordinator.shared.moveTo(Route.buyGodVerify)
  }
  
  private func setupNavigation() {
    addNavigation(title: Text.localizedString("BuyGod.NaviTitle"))
    navigationView.setRightIcon("ic_info")
  }
  
  override func naviRightAction() {
    // todo right action
  }
  
  private func setupCommon() {
    containerView.backgroundColor = bgColor
    view.backgroundColor = bgColor
    [referUserView, dueDateView].forEach({ view in
      Apply(view!) {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
      }
    })
  }
  
  private func setupPickerView() {
    let scrH = UIScreen.main.bounds.height
    let scrW = UIScreen.main.bounds.width
    Apply(picker) {
      $0.frame = CGRect(x: 0, y: scrH - 250, width: scrW, height: 250)
      $0.isHidden = true
      $0.onDismiss = { [weak self] in
        self?.dismissPicker()
      }
    }
    view.addSubview(picker)
  }
  
  private func setupDatePicker() {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: Text.localizedString("Button.Done"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(donedatePicker))
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                target: nil,
                                action: nil)
    toolbar.setItems([space, doneButton], animated: false)
    dueDateTf.inputAccessoryView = toolbar
    datePicker.datePickerMode = .date
    dueDateTf.inputView = datePicker
    if #available(iOS 13.4, *) {
      datePicker.preferredDatePickerStyle = .wheels
    }
    datePicker.addTarget(self,
                         action: #selector(datePickerChanged(picker:)),
                         for: .valueChanged)
  }
  
  @objc
  private func donedatePicker() {
    dueDateTf.resignFirstResponder()
  }
  
  @objc
  private func datePickerChanged(picker: UIDatePicker) {
    dueDateTf.text = picker.date.toString(format: "yyyy/MM/dd")
  }
  
  private func showPickerView(_ datas: [String]) {
    picker.datas = datas
    guard picker.isHidden else {
      return
    }
    picker.isHidden = false
    UIView.animate(withDuration: 0.25) {
      self.picker.frame.origin.y = UIScreen.main.bounds.height - self.picker.bounds.height
      self.picker.alpha = 1
    }
  }
  
  private func dismissPicker() {
    picker.onSelected = nil
    UIView.animate(withDuration: 0.25) {
      self.picker.frame.origin.y = 1000
      self.picker.alpha = 0
    } completion: { success in
      self.picker.isHidden = true
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
      $0.setTitle(Text.localizedString("BuyGod.Policy"))
      $0.setMessage("")
    }
    dueDateLb.text = Text.localizedString("BuyGod.DueDate")
    periodView.setTitle(Text.localizedString("BuyGod.StorageTerm"))
    storageFeeView.setTitle(Text.localizedString("BuyGod.StorageFee"))
    
    continueBtn.setTitle(Text.localizedString("Button.Continue"), for: .normal)
  }
  private func setupValueChange() {
    quantityView.onValueChange = { [weak self] value in
      self?.quantity = value
    }
    cityView.addTapGes { [weak self] in
      self?.showCityPicker()
    }
    districtView.addTapGes { [weak self] in
      self?.showDistrictPicker()
    }
    transactionPlaceView.addTapGes { [weak self] in
      self?.showTransactionPlacePicker()
    }
    deliveryFormView.addTapGes { [weak self] in
      self?.showDeliveryPicker()
    }
    transactionTypeView.addTapGes { [weak self] in
      self?.showTransactionClassifyPicker()
    }
    promotionView.addTapGes { [weak self] in
      self?.showPronotionPicker()
    }
  }
  
  private func updateDeliveryUI() {
    switch deliveryType {
    case .appointment:
      storageWithTermView.isHidden = true
      storageWithTermHeight.constant = 0
      immediatelyHeight.constant = 80
      goldImmediatelyView.isHidden = false
    default:
      immediatelyHeight.constant = 0
      goldImmediatelyView.isHidden = true
      storageWithTermView.isHidden = false
      storageWithTermHeight.constant = 150
    }
  }
  
  private func showCityPicker() {
    showPickerView(["Hà Nội", "Huế", "Đà Nẵng", "Nha Trang", "Hồ Chí Minh", "Vũng Tàu"])
    picker.onSelected = { [weak self] index, value in
      self?.cityView.content = value
    }
  }
  
  private func showDistrictPicker() {
    showPickerView(["Hoàn Kiếm", "Thanh Xuân", "Hà Đông", "Cầu Giấy", "Đống Đa", "Hai Bà Trưng"])
    picker.onSelected = { [weak self] index, value in
      self?.districtView.content = value
    }
  }
  
  private func showTransactionPlacePicker() {
    showPickerView(["PGD Vạn Xuân - 38 Yết Kiêu Hoàn Kiếm", "PGD X - Hai Bà Trưng", "PGD Y - Cầu Giấy", "PGD Z Đống Đa"])
    picker.onSelected = { [weak self] index, value in
      self?.transactionPlaceView.content = value
    }
  }
  
  private func showDeliveryPicker() {
    let titles = DeliveryType.allCases.map({ $0.title })
    showPickerView(titles)
    picker.onSelected = { [weak self] index, value in
      guard let `self` = self else { return }
      self.deliveryFormView.content = value
      self.deliveryType = DeliveryType.allCases[index]
    }
  }
  private func showTransactionClassifyPicker() {
    showPickerView(["Transaction 1", "Transaction 2", "Transaction 3"])
    picker.onSelected = { [weak self] index, value in
      self?.transactionTypeView.content = value
    }
  }
  private func showPronotionPicker() {
    showPickerView(["Promotion 1", "Promotion 2", "Promotion 3"])
    picker.onSelected = { [weak self] index, value in
      self?.promotionView.content = value
    }
  }
}
