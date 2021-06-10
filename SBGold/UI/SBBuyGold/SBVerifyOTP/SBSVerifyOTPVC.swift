//
//  SBSVerifyOTPVC.swift
//  SBGold
//
//  Created by Anonymos on 10/06/2021.
//

import UIKit

class SBSVerifyOTPVC: SBSGoldBaseVC {
  @IBOutlet weak private var noticeLb: UILabel!
  @IBOutlet weak private var pwView: UIView!
  @IBOutlet weak private var pwTf: UITextField!
  @IBOutlet weak private var optTf: UITextField!
  
  @IBOutlet weak private var secretBtn: UIButton!
  @IBOutlet weak private var nextBtn: UIButton!
  
  @IBOutlet private var otpsLb: [UILabel]!
  
  private var isSecretPW: Bool = true {
    didSet {
      pwTf.isSecureTextEntry = isSecretPW
    }
  }
  
  override func setupView() {
    addNavigation(title: Text.localizedString("BuyGoldOTP.NaviTitle"))
    isSecretPW = true
    setupCommon()
    setupMultiLanguage()
    addObservable(buttons: [secretBtn, nextBtn])
  }
  
  private func setupCommon() {
    Apply(optTf!) {
      $0.delegate = self
      $0.addTarget(self, action: #selector(otpDidChange), for: .editingChanged)
      $0.keyboardType = .numberPad
    }
    otpsLb.forEach({ label in
      Apply(label) {
        $0.text = ""
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
        $0.cornerRadius = 5
        $0.clipsToBounds = true
      }
    })
    Apply(pwView!) {
      $0.layer.borderWidth = 1
      $0.layer.borderColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
      $0.cornerRadius = 5
      $0.clipsToBounds = true
    }
    pwTf.delegate = self
  }
  
  private func setupMultiLanguage() {
    noticeLb.text = Text.localizedString("BuyGoldOTP.Notice")
    pwTf.placeholder = Text.localizedString("BuyGoldOTP.EnterPassword")
  }
  
  @objc
  private func otpDidChange() {
    let keys = Array(optTf.text ?? "")
    for (index, label) in otpsLb.enumerated() {
      if let character = keys.safeValue(at: index) {
        label.text = String(character)
      } else {
        label.text = ""
      }
    }
  }
  
  override func didTapButton(_ btn: UIButton) {
    switch btn {
    case nextBtn:
      break
    case secretBtn:
      isSecretPW = !isSecretPW
    default:
      break
    }
  }
}

extension SBSVerifyOTPVC: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    if textField == pwTf {
      return true
    }
    guard !string.isEmpty else { return true }
    let finalText = (textField.text.stringValue() + string).replacingOccurrences(of: ",", with: "")
    let shouldChange = finalText.count <= 6
    return shouldChange
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
