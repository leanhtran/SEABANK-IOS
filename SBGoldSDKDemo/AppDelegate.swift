//
//  AppDelegate.swift
//  XTest
//
//  Created by Anonymos on 02/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let vc = HomeViewViewController()
    let navi = UINavigationController(rootViewController: vc)
    navi.isNavigationBarHidden = true
    
    if window == nil {
      window = UIWindow(frame: UIScreen.main.bounds)
    }
    window?.rootViewController = navi
    window?.makeKeyAndVisible()
    
    return true
  }
}
