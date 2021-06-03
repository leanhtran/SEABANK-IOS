//
//  HomeViewViewController.swift
//  XTest
//
//  Created by Anonymos on 02/06/2021.
//

import UIKit
import SBGoldSDK

class HomeViewViewController: UIViewController {
  
  @IBAction func showGold(_ sender: Any) {
    let vc = SBSGoldVC()
    navigationController?.pushViewController(vc, animated: true)
  }
}
