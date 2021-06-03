//
//  ViewWithXib.swift
import UIKit

class ViewWithXib: UIView {
  
  private(set) var contentView: UIView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupNibView()
    
    if #available(iOS 13.0, *) {
      // Always adopt a light interface style.
      overrideUserInterfaceStyle = .light
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupNibView()
    setupView()
  }
  
  func addObservable(buttons: [UIButton]) {
    for (_, btn) in buttons.enumerated() {
      btn.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
  }
  
  @objc internal func didTapButton(_ btn: UIButton) { }
  
  private func setupNibView() {
    let view = viewFromNibForClass()
    view.frame = bounds
    view.autoresizingMask = [
      UIView.AutoresizingMask.flexibleWidth,
      UIView.AutoresizingMask.flexibleHeight
    ]
    addSubview(view)
    contentView = view
  }
  
  func setupView() { }
}

protocol XibInitializable {}

extension XibInitializable where Self: UIView {
  static func fromXib(name: String = className) -> Self {
    guard let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? Self else {
      fatalError("nib name not found")
    }
    return view
  }
}
