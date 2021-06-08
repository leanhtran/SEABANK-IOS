//
//  SBSGoldInfoDetailVC.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit

class SBSGoldInfoDetailVC: SBSGoldBaseVC {
  @IBOutlet private var featureBtn: [SBSShadowButton]!
  @IBOutlet weak private var tbView: UITableView!
  @IBOutlet weak private var featureButtonHeight: NSLayoutConstraint!
  
  enum FeatureButton: Int {
    case withDraw
    case buyGold
    case viewContract
    
    var title: String {
      switch self {
      case .withDraw:
        return Text.localizedString("GoldInfoDetail.WithDrawal")
      case .buyGold:
        return Text.localizedString("GoldInfoDetail.BuyGold")
      case .viewContract:
        return Text.localizedString("GoldInfoDetail.ViewContract")
      }
    }
  }
  
  struct DataSource {
    var title: String
    var value: String
  }
  
  var isPeriod: Bool = true
  
  private var datas: [DataSource] = [] {
    didSet {
      tbView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.DepositForm"), value: "Online"))
    datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.StorageForm"), value: "Thông thường"))
    datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.ContractNumber"), value: "A1234BCD"))
    datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.GoldType"), value: "Vàng JSC"))
    datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.Quantity"), value: "2 chỉ"))
    datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.DeliveryForm"), value: "Hẹn trả"))
    datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.BuyDate"), value: "12/12/2020"))

    if isPeriod {
      datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.DueDate"), value: "12/12/2022"))
      datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.Period"), value: "3 tháng"))
      datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.TransactionPlace"), value: "PGD Vạn Xuân - 38 Yết Kiêu - Hoàn Kiếm"))
      datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.PayableFee"), value: "400,000 VND"))
    } else {
      datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.AppointmentDate"), value: "12/12/2022"))
      datas.append(DataSource(title: Text.localizedString("GoldInfoDetail.TransactionPlace"), value: "PGD Vạn Xuân - 38 Yết Kiêu - Hoàn Kiếm"))
    }
    
    var features: [FeatureButton] = [.buyGold, .viewContract]
    if isPeriod {
      features.insert(.withDraw, at: 0)
    }
    for (index, button) in featureBtn.enumerated() {
      if let feature = features.safeValue(at: index) {
        button.setTitle(feature.title, for: .normal)
        button.tag = feature.rawValue
      } else {
        button.isHidden = true
        button.tag = 111
      }
    }
  }

  override func setupView() {
    addNavigation(title: Text.localizedString("GoldInfoDetail.NaviTitle"))
    setupTbView()
    addObservable(buttons: featureBtn)
  }
  
  override func didTapButton(_ btn: UIButton) {
    guard let feature = FeatureButton(rawValue: btn.tag) else { return }
    switch feature {
    case .withDraw:
      SBSCoordinator.shared.moveTo(Route.goldWithdraw)
    default:
      break
    }
  }
  
  private func setupTbView() {
    tbView.register(SBSFormInfoCell.self)
    tbView.delegate = self
    tbView.dataSource = self
  }
}

extension SBSGoldInfoDetailVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return datas.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = datas[indexPath.row]
    let cell = Init(tbView.dequeue(SBSFormInfoCell.self)) {
      $0.setTitle(item.title)
      $0.bindData(item.value)
      $0.backgroundColor = bgColor
    }
    
    return cell
  }
}
