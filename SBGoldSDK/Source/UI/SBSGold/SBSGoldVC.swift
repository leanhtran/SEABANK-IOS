//
//  SBSGoldVC.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import UIKit

public enum SBSGoldItemEnum: CaseIterable {
  case goldInfo
  case buyGold
  
  var title: String {
    switch self {
    case .goldInfo:
      return "Thông tin mua vàng"
    case .buyGold:
      return "Mua vàng"
    }
  }
}

open class SBSGoldVC: SBSGoldBaseVC {
  @IBOutlet weak private var collectionView: UICollectionView!
  
  public init() {
    let nibName = String(describing: type(of: self))
    super.init(nibName: nibName, bundle: Bundle.staticBundle)
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let insets: UIEdgeInsets = .zero
  
  override func setupView() {
    addNavigation(title: "Hello")
    collectionView.register(SBSGoldItemCell.self)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  public var items: [SBSGoldItemEnum] = SBSGoldItemEnum.allCases {
    didSet {
      collectionView.reloadData()
    }
  }
}

extension SBSGoldVC: UICollectionViewDelegate, UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = items[indexPath.row]
    let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: "SBSGoldItemCell",
                           for: indexPath)
    return cell
  }
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}

extension SBSGoldVC: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 60, height: 100)
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             insetForSectionAt section: Int) -> UIEdgeInsets {
    return insets
  }
}
