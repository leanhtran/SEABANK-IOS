import UIKit

final class InputTextView: ViewWithXib {
  @IBOutlet weak private var titleLb: UILabel!
  @IBOutlet weak private var bottomTitleLb: UILabel!
  @IBOutlet weak private var inputTf: UITextField!
  @IBOutlet weak private var leadingSpace: NSLayoutConstraint!
  @IBOutlet weak private var containerView: UIView!
  
  var keyboardType: UIKeyboardType = .default {
    didSet {
      inputTf.keyboardType = keyboardType
    }
  }
  
  var picker: UIPickerView? {
    didSet {
      inputTf.inputView = picker
    }
  }
  
  var autocapitalizationType: UITextAutocapitalizationType = .words {
    didSet {
      inputTf.autocapitalizationType = autocapitalizationType
    }
  }
  
  var editEnable: Bool = true {
    didSet {
      inputTf.isUserInteractionEnabled = editEnable
    }
  }
  
  var title: String = "" {
    didSet {
      titleLb.text = title
    }
  }
  
  var titleAttr: NSAttributedString? {
    didSet {
      titleLb.attributedText = titleAttr
    }
  }
  
  var bottomTitle: String = "" {
    didSet {
      bottomTitleLb.text = bottomTitle
    }
  }
  
  var placeHolder: String = ""{
    didSet {
      inputTf.placeholder = placeHolder
    }
  }
  
  var content: String {
    set {
      inputTf.text = newValue
      inputTf.sendActions(for: .valueChanged)
    }
    
    get {
      return inputTf.text ?? ""
    }
  }
  
  var titleColor: UIColor = .darkText {
    didSet {
      titleLb.textColor = titleColor
    }
  }
  
  var bottomTitleColor: UIColor = .darkText {
    didSet {
      bottomTitleLb.textColor = bottomTitleColor
    }
  }
  
  var isSecureTextEntry: Bool = false {
    didSet {
      inputTf.isSecureTextEntry = isSecureTextEntry
    }
  }
  
  var leading: CGFloat = 0 {
    didSet {
      leadingSpace.constant = leading
    }
  }
  
  var maximum: Int = 1000

  var onTextChange: ((String) -> Void)?
  
  func firstResponder(_ enable: Bool) {
    if enable {
      inputTf.becomeFirstResponder()
    } else {
      inputTf.resignFirstResponder()
    }
  }
  
  func setDisable() {
    inputTf.alpha = 0.5
    editEnable = false
  }
  
  override func setupView() {
    inputTf.delegate = self
    titleLb.text = ""
    bottomTitleLb.text = ""
    inputTf.setEdgeInsets(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    inputTf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    Apply(containerView!) {
      $0.layer.borderWidth = 1
      $0.layer.borderColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
      $0.clipsToBounds = true
      $0.layer.cornerRadius = 5
    }
  }
  
  @objc
  private func textFieldDidChange() {
    onTextChange?(inputTf.text.stringValue())
  }
  
  @objc
  private func datePickerValueChanged(_ picker: UIPickerView) {
    
  }
}

extension InputTextView: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard !string.isEmpty else { return true }
    let finalText = (textField.text.stringValue() + string).replacingOccurrences(of: ",", with: "")
    let shouldChange = finalText.count <= maximum
    return shouldChange
  }
}
