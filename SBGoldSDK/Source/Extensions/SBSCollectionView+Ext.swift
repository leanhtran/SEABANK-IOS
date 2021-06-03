//
//  SBSCollectionView+Ext.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import UIKit

extension UICollectionView {
  func register<T: UICollectionViewCell>(_ aClass: T.Type) {
    let name = String(describing: aClass)
    let bundle = Bundle.staticBundle ?? Bundle.main
    if bundle.path(forResource: name, ofType: "nib") != nil {
      let nib = UINib(nibName: name, bundle: bundle)
      register(nib, forCellWithReuseIdentifier: name)
    } else {
      register(aClass, forCellWithReuseIdentifier: name)
    }
  }
  
  func dequeue<T: UICollectionViewCell>(_ aClass: T.Type, indexPath: IndexPath) -> T {
    let name = String(describing: aClass)
    guard let cell = dequeueReusableCell(withReuseIdentifier: name, for: indexPath) as? T else {
      fatalError("\(name) is not registed")
    }
    return cell
  }
}
