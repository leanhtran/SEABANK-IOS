//
//  AppDelegate.swift
//  SBGold
//
//  Created by Anonymos on 07/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let vc = SBSGoldVC()
    let navi = UINavigationController(rootViewController: vc)
    SBSCoordinator.shared.navigation = navi
    
    if window == nil {
      window = UIWindow(frame: UIScreen.main.bounds)
    }
    window?.rootViewController = navi
    window?.makeKeyAndVisible()
    
    return true
  }
}

