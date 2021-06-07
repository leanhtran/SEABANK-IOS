import UIKit

final class SBSInfoView: ViewWithXib {
  @IBOutlet weak private var titleLb: UILabel!
  @IBOutlet weak private var contentLb: UILabel!
  
  var titleColor: UIColor? {
    didSet {
      titleLb.textColor = tintColor
    }
  }
  
  var contentFont: UIFont? {
    didSet {
      contentLb.font = contentFont
    }
  }
  
  func setTitle(_ text: String) {
    titleLb.text = text
  }
  
  func setContent(_ text: String) {
    contentLb.text = text
  }
}
