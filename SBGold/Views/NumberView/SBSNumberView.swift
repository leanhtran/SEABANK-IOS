//
//  SBSNumberView.swift
//  SBGold
//
//  Created by Anonymos on 07/06/2021.
//

import UIKit

final class SBSNumberView: ViewWithXib {
  @IBOutlet weak private var numberLb: UILabel!
  @IBOutlet weak private var increaseBtn: UIButton!
  @IBOutlet weak private var decreaseBtn: UIButton!
  @IBOutlet weak private var titleLb: UILabel!
  @IBOutlet weak private var containerView: UIView!
  
  var onValueChange: ((Int) -> ())?
  
  override func setupView() {
    addObservable(buttons: [increaseBtn, decreaseBtn])
    Apply(containerView!) {
      $0.layer.cornerRadius = 5
      $0.clipsToBounds = true
      $0.layer.borderWidth = 1
      $0.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
    }
  }
  
  override func didTapButton(_ btn: UIButton) {
    let currentValue = numberLb.text.stringValue().intValue()
    var newValue: Int = 0
    switch btn {
    case increaseBtn:
      newValue = currentValue + 1
    case decreaseBtn:
      newValue = max(currentValue - 1, 0)
    default:
      break
    }
    numberLb.text = newValue.toString()
    onValueChange?(newValue)
  }
  
  func setTitle(_ text: String) {
    
  }
}
