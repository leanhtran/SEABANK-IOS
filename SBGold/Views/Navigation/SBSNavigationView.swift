import UIKit

class SBSNavigationView: UIView {
  private let backBtn = UIButton()
  private let rightBtn = UIButton()
  private let titleLb = UILabel()
  
  var shapeLayer: CAShapeLayer!
  
  enum Action {
    case back
    case right
  }
  
  let maxW = UIScreen.main.bounds.width
  let curveX1: CGFloat = 120
  let curveX2: CGFloat = 80
  
  let centerY: CGFloat = 10
  let bottomY: CGFloat = 50
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    shapeLayer = CAShapeLayer()
    shapeLayer.fillColor = mainColor.cgColor
    layer.addSublayer(shapeLayer)
    shapeLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
    
    let scrW = UIScreen.main.bounds.width
    
    Apply(titleLb) {
      $0.font = UIFont.systemFont(ofSize: 16)
      $0.textColor = UIColor.white
      $0.textAlignment = .center
      $0.frame = CGRect(x: curveX1, y: 20, width: scrW - 2 * curveX1, height: 30)
    }
    
    Apply(backBtn) {
      $0.setImage(UIImage(named: "ic_back"), for: .normal)
      $0.frame = CGRect(x: 0, y: 20, width: 50, height: 50)
    }
    
    Apply(rightBtn) {
      $0.frame = CGRect(x: scrW - 60, y: 20, width: 50, height: 50)
    }
    
    addSubview(titleLb)
    addSubview(backBtn)
    addSubview(rightBtn)
    
    addObservable(buttons: [backBtn, rightBtn])
    backgroundColor = bgColor
  }
  
  func addObservable(buttons: [UIButton]) {
    for (_, btn) in buttons.enumerated() {
      btn.isUserInteractionEnabled = true
      btn.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var action: ((Action) -> ())?

  @objc internal func didTapButton(_ btn: UIButton) {
    switch btn {
    case backBtn:
      action?(.back)
    case rightBtn:
      action?(.right)
    default:
      break
    }
  }
  
  func setTitle(_ text: String) {
    titleLb.text = text
  }
  
  func setRightIcon(_ image: String) {
    rightBtn.setImage(UIImage(named: image), for: .normal)
  }
  
  override func draw(_ rect: CGRect) {
    let path = createBezierPath()
    shapeLayer.path = path.cgPath
  }
}

extension SBSNavigationView {
  func createBezierPath() -> UIBezierPath {
    // create a new path
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: maxW, y: 0))
    path.addLine(to: CGPoint(x: maxW, y: 0))
    path.addLine(to: CGPoint(x: maxW, y: centerY))
    path.addLine(to: CGPoint(x: maxW - 40, y: centerY))
    
    path.addCurve(to: CGPoint(x: maxW - curveX1, y: bottomY), // ending point
                  controlPoint1: CGPoint(x: maxW - curveX2, y: centerY),
                  controlPoint2: CGPoint(x: maxW - curveX2, y: bottomY))
    
    path.addLine(to: CGPoint(x: curveX1, y: bottomY))
    
    path.addCurve(to: CGPoint(x: 40, y: centerY), // ending point
                  controlPoint1: CGPoint(x: curveX2, y: bottomY),
                  controlPoint2: CGPoint(x: curveX2, y: centerY))
    
    path.addLine(to: CGPoint(x: 0, y: centerY))
    
    path.close() // draws the final line to close the path
    
    return path
  }
}
