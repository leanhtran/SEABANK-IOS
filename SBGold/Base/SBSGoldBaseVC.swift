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
    subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
    subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
    setupView()
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromAllNotifications()
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
    let safeAreaView = UIView(frame: CGRect(x: 0, y: 0,
                                            width: UIScreen.main.bounds.width,
                                            height: safeArea))
    safeAreaView.backgroundColor = mainColor
    view.embedded(view: safeAreaView, height: safeArea)
    view.embedded(view: navigationView, top: safeArea, height: 70)
    Apply(navigationView) {
      $0.setTitle(title)
      $0.action = { [weak self] ac in
        if ac == .back {
          self?.backToPrev()
        } else {
          self?.naviRightAction()
        }
      }
    }
  }
}

extension SBSGoldBaseVC {
  @objc func dismissMyKeyboard(){
    view.endEditing(true)
  }
  
  func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
    NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
  }
  
  func unsubscribeFromAllNotifications() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func keyboardWillShowOrHide(notification: NSNotification) {
    guard let scrollView = view.subviews.first(where: { $0.isKind(of: UIScrollView.self )}) as? UIScrollView,
          let userInfo = notification.userInfo,
          let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey],
          let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey],
          let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] else { return }
    
    // Transform the keyboard's frame into our view's coordinate system
    let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
    
    // Find out how much the keyboard overlaps the scroll view
    // We can do this because our scroll view's frame is already in our view's coordinate system
    let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
    
    // Set the scroll view's content inset to avoid the keyboard
    // Don't forget the scroll indicator too!
    scrollView.contentInset.bottom = keyboardOverlap
    scrollView.scrollIndicatorInsets.bottom = keyboardOverlap
    
    let duration = (durationValue as AnyObject).doubleValue
    let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
    UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
}
