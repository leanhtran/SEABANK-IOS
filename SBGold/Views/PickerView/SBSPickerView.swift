//
//  SBSPickerView.swift
//  SBGold
//
//  Created by Anonymos on 2021/06/07.
//

import UIKit

class SBSPickerView: ViewWithXib {
  @IBOutlet weak private var pickerView: UIPickerView!
  @IBOutlet weak private var doneBtn: UIButton!
  
  var onDismiss: (() -> ())?
  var onSelected: ((Int, String) -> ())?
 
  override func setupView() {
    pickerView.delegate = self
    pickerView.dataSource = self
    addObservable(buttons: [doneBtn])
  }

  override func didTapButton(_ btn: UIButton) {
    onDismiss?()
  }
  
  var datas: [String] = [] {
    didSet {
      pickerView.reloadAllComponents()
    }
  }
}

extension SBSPickerView: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.datas.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let itemValue = self.datas[row]
    return itemValue
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 40
  }
}

// MARK: - UIPickerViewDelegate Functions
extension SBSPickerView: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let itemValue = self.datas[row]
    onSelected?(row, itemValue)
  }
}
