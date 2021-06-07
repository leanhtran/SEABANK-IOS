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
      return Text.localizedString("GoldVC.GoldInfo")
    case .buyGold:
      return Text.localizedString("GoldVC.BuyGold")
    }
  }
}

open class SBSGoldVC: SBSGoldBaseVC {
  @IBOutlet weak private var collectionView: UICollectionView!
  
  let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  
  override func setupView() {
    addNavigation(title: Text.localizedString("GoldVC.Navi.Title"))
    navigationView.setRightIcon("ic_info")
    collectionView.register(SBSGoldItemCell.self)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView.reloadData()
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
    let cell = collectionView.dequeue(SBSGoldItemCell.self, indexPath: indexPath)
    cell.bindData("ic_", title: item.title)
    return cell
  }
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = items[indexPath.row]
    switch item {
    case .buyGold:
      SBSCoordinator.shared.moveTo(Route.buyGod)
    case .goldInfo:
      break
    }
  }
}

extension SBSGoldVC: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 80, height: 130)
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
