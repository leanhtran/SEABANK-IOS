//
//  NavigationView.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import UIKit

class SBSNavigationView: ViewWithXib {
  @IBOutlet weak private var bgImv: UIImageView!
  @IBOutlet weak private var leftBtn: UIButton!
  @IBOutlet weak private var rightBtn: UIButton!
  @IBOutlet weak private var titleLb: UILabel!
  
  enum Action {
    case left
    case right
  }
  
  var action: ((Action) -> ())?
  
  override func setupView() {
    addObservable(buttons: [leftBtn, rightBtn])
  }
  
  override func didTapButton(_ btn: UIButton) {
    switch btn {
    case leftBtn:
      action?(.left)
    case rightBtn:
      action?(.right)
    default:
      break
    }
  }
  
  func setTitle(_ text: String) {
    titleLb.text = text
  }
}
