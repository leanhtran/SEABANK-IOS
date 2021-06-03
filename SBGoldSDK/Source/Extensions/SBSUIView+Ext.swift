//
//  UIView+Ext.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import UIKit

extension UIView {
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set(value) {
      layer.cornerRadius = value
    }
  }
  
  func viewFromNibForClass() -> UIView {
    let bundle = Bundle.staticBundle!
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
      return UIView()
    }
    return view
  }
  
  func embedded(view: UIView, top: CGFloat = 0, height: CGFloat = 0) {
    addSubview(view)
    Apply(view) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
      $0.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
      if height > 0 {
        $0.heightAnchor.constraint(equalToConstant: 56.0).isActive = true
      } else {
        $0.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
      }
    }
  }
}
