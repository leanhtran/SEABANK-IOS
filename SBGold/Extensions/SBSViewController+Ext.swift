import UIKit

public extension UIViewController {
  
  //** loads instance from right framework bundle, not main bundle as UIViewController.init() does
  private static func genericInstance<T: UIViewController>() -> T {
    return T.init(nibName: String(describing: self), bundle: Bundle(for: self))
  }
  
  static func instance() -> Self {
    return genericInstance()
  }
}
