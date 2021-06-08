//
//  SBSCoordinator.swift
//  SBGold
//
//  Created by Anonymos on 07/06/2021.
//

import UIKit

enum Route {
  case buyGod
  case buyGodVerify
  case goldInfo
  case goldInfoDetail
  case goldWithdraw
}

class BaseCoordinator {
  var navigation: UINavigationController? {
    didSet {
      navigation?.isNavigationBarHidden = true
    }
  }
  
  func push(_ vc: UIViewController?, animated: Bool = true) {
    guard let vc = vc else { return }
    navigation?.pushViewController(vc, animated: animated)
  }
}

final class SBSCoordinator: BaseCoordinator {
  
  static let shared = SBSCoordinator()
  
  func moveTo(_ route: Any) {
    guard let route = route as? Route else { return }
    switch route {
    case .buyGod:
      push(SBBuyGoldVC())
    case .buyGodVerify:
      push(SBSVerifyBuyInfoVC())
    case .goldInfo:
      push(SBSGoldInfoVC())
    case .goldInfoDetail:
      push(SBSGoldInfoDetailVC())
    case .goldWithdraw:
      push(SBSGodWithdrawVC())
    }
  }
}
