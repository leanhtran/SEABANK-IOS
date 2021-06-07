//
//  SBSCoordinator.swift
//  SBGold
//
//  Created by Anonymos on 07/06/2021.
//

import UIKit

enum Route {
  case buyGod
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
    }
  }
}
