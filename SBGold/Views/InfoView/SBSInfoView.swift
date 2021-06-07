import UIKit

final class SBSInfoView: ViewWithXib {
  @IBOutlet weak private var titleLb: UILabel!
  @IBOutlet weak private var contentLb: UILabel!
  
  func setTitle(_ text: String) {
    titleLb.text = text
  }
  
  func setContent(_ text: String) {
    contentLb.text = text
  }
}
