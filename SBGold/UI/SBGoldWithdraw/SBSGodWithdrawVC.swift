//
//  SBSGodWithdrawVC.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit

class SBSGodWithdrawVC: SBSGoldBaseVC {
  @IBOutlet weak private var withdrawPlaceLb: UILabel!
  @IBOutlet weak private var cityView: InputTextView!
  @IBOutlet weak private var districtView: InputTextView!
  @IBOutlet weak private var transactionPlaceView: InputTextView!
  @IBOutlet weak private var withdrawDateLb: UILabel!
  @IBOutlet weak private var dateView: UIView!
  @IBOutlet weak private var dateTf: UITextField!
  @IBOutlet weak private var feeView: SBSInfoView!
  @IBOutlet weak private var feeInfoLb: UILabel!
  @IBOutlet weak private var noticeLb: UILabel!
  @IBOutlet weak private var nextBtn: UIButton!
  
  let picker = SBSPickerView()
  let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    feeView.setContent("400,000 VND")
  }
  
  override func setupView() {
    addNavigation(title: Text.localizedString("GoldWithdraw.Register"))
    addObservable(buttons: [nextBtn])
    setupMultiLanguage()
    setupCommon()
    setupPickerView()
    setupDatePicker()
  }
  
  override func didTapButton(_ btn: UIButton) {
    SBSCoordinator.shared.moveTo(Route.withdrawConfirm)
  }
  
  private func setupCommon() {
    view.backgroundColor = bgColor
    Apply(dateView!) {
      $0.layer.borderWidth = 1
      $0.layer.borderColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
      $0.clipsToBounds = true
      $0.layer.cornerRadius = 5
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
  }
  
  private func setupMultiLanguage() {
    withdrawPlaceLb.text = Text.localizedString("GoldWithdraw.Place")
    cityView.title = Text.localizedString("GoldWithdraw.SelectCity")
    districtView.title = Text.localizedString("GoldWithdraw.SelectDistrict")
    transactionPlaceView.title = Text.localizedString("GoldWithdraw.SelectTransactionPlace")
    withdrawDateLb.text = Text.localizedString("GoldWithdraw.WithdrawDate")
    feeView.setTitle(Text.localizedString("GoldWithdraw.WithdrawFee"))
    feeInfoLb.text = Text.localizedString("GoldWithdraw.WithdrawInfo")
    noticeLb.text = Text.localizedString("GoldWithdraw.WithdrawNotice")
    nextBtn.setTitle(Text.localizedString("Button.Continue"), for: .normal)
  }
}

extension SBSGodWithdrawVC {
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
}

extension SBSGodWithdrawVC {
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
    dateTf.inputAccessoryView = toolbar
    datePicker.datePickerMode = .date
    dateTf.inputView = datePicker
    if #available(iOS 13.4, *) {
      datePicker.preferredDatePickerStyle = .wheels
    }
    datePicker.addTarget(self,
                         action: #selector(datePickerChanged(picker:)),
                         for: .valueChanged)
  }
  
  @objc
  private func donedatePicker() {
    dateTf.resignFirstResponder()
  }
  
  @objc
  private func datePickerChanged(picker: UIDatePicker) {
    dateTf.text = picker.date.toString(format: "dd/MM/yyyy")
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
}
