import UIKit

extension UITextField {
  func setEdgeInsets(_ insets: UIEdgeInsets) {
    if insets.left != 0 {
      self.leftView = UIView(frame: CGRect(x: 0, y: 0,
                                           width: insets.left,
                                           height: frame.size.height))
      self.leftViewMode = .always
    }
    if insets.right != 0 {
      self.rightView = UIView(frame: CGRect(x: 0, y: 0,
                                            width: insets.right,
                                            height: frame.size.height))
      self.rightViewMode = .always
    }
  }
}
