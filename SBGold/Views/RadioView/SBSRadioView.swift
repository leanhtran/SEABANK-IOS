//
//  SBSRadioView.swift
//  SBGold
//
//  Created by Anonymos on 2021/06/07.
//

import UIKit

final class SBSRadioView: ViewWithXib {
  @IBOutlet weak private var leftLb: UILabel!
  @IBOutlet weak private var rightLb: UILabel!
  @IBOutlet weak private var leftImv: UIImageView!
  @IBOutlet weak private var rightImv: UIImageView!
  @IBOutlet weak private var leftBtn: UIButton!
  @IBOutlet weak private var rightBtn: UIButton!
  
  var onSelected: ((Int) -> ())?
  
  override func setupView() {
    addObservable(buttons: [leftBtn, rightBtn])
  }
  
  override func didTapButton(_ btn: UIButton) {
    for(index, button) in [leftBtn, rightBtn].enumerated() {
      let isSelected = button == btn
      if isSelected {
        onSelected?(index)
      }
      let img = isSelected ? "ic_radio_checked" : "ic_radio"
      [leftImv, rightImv][index]?.image = UIImage(named: img)
    }
  }
  
  func setRadioTitle(_ titles: [String]) {
    leftLb.text = titles.first
    rightLb.text = titles.last
  }
}
