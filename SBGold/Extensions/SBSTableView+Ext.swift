//
//  SBSTableView+Ext.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit


extension UITableView {
  func register<T: UITableViewCell>(_ aClass: T.Type) {
    let name = String(describing: aClass)
    let bundle = Bundle.main
    if bundle.path(forResource: name, ofType: "nib") != nil {
      let nib = UINib(nibName: name, bundle: bundle)
      register(nib, forCellReuseIdentifier: name)
    } else {
      register(aClass, forCellReuseIdentifier: name)
    }
  }
  
  func dequeue<T: UITableViewCell>(_ aClass: T.Type) -> T {
    let name = String(describing: aClass)
    guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
      fatalError("`\(name)` is not registed")
    }
    return cell
  }
}
