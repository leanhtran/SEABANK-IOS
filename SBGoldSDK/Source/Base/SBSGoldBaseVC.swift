//
//  SBSGoldBaseVC.swift
//  SBGoldSDK
//
//  Created by Anonymos on 2021/06/01.
//

import UIKit

open class SBSGoldBaseVC: UIViewController {
  
  private(set) lazy var navigationView: SBSNavigationView = {
    return SBSNavigationView()
  }()
  
  public override var preferredStatusBarStyle: UIStatusBarStyle {
    if #available(iOS 13.0, *) {
      return .darkContent
    } else {
      return .default
    }
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOS 13.0, *) {
      overrideUserInterfaceStyle = .light
    }
    
    setupView()
  }
  
  internal func setupView() {}
  internal func naviRightAction() {}
  @objc
  internal func didTapButton(_ btn: UIButton) { }
  internal func backToPrev(animated: Bool = true) {
    navigationController?.popViewController(animated: animated)
  }
  internal func dismiss(animated: Bool = true) {
    dismiss(animated: animated, completion: nil)
  }
  
  public override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    SBSLog.debug(message: className + "didReceiveMemoryWarning")
  }
  
  deinit {
    SBSLog.debug(message: className + " deinit")
  }
}

extension SBSGoldBaseVC {
  func addObservable(buttons: [UIButton]) {
    for (_, btn) in buttons.enumerated() {
      btn.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
  }
  
  func addNavigation(title: String, safeArea: CGFloat = SBSDimensions.topArea()) {
    view.embedded(view: navigationView, top: safeArea, height: 60)
    Apply(navigationView) {
      $0.setTitle(title)
      $0.action = { [weak self] ac in
        if ac == .left {
          self?.backToPrev()
        } else {
          self?.naviRightAction()
        }
      }
    }
  }
}

