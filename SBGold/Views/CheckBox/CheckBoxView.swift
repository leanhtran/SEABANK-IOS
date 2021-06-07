//
//  CheckBoxView.swift
//  SBGold
//
//  Created by Anonymos on 07/06/2021.
//

import UIKit

final class CheckBoxView: ViewWithXib {
  @IBOutlet weak private var checkBtn: UIButton!
  @IBOutlet weak private var titleLb: UILabel!
  @IBOutlet weak private var messageLb: UILabel!
  @IBOutlet weak private var checkImv: UIImageView!
  
  var onValueChange: ((Bool) -> ())?
  
  var isSelected: Bool = false {
    didSet {
      let img = isSelected ? "ic_box_checked" : "ic_box"
      checkImv.image = UIImage(named: img)
    }
  }
  
  override func setupView() {
    addObservable(buttons: [checkBtn])
  }
  
  override func didTapButton(_ btn: UIButton) {
    isSelected = !isSelected
    onValueChange?(isSelected)
  }
  
  func setTitle(_ text: String) {
    titleLb.text = text
  }
  
  func setMessage(_ text: String) {
    messageLb.text = text
  }
}
