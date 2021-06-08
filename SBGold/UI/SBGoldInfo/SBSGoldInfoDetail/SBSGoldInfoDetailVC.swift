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
    
    var keys = ["GoldInfoDetail.BuyGold", "GoldInfoDetail.ViewContract"]
    if isPeriod {
      keys.insert("GoldInfoDetail.WithDrawal", at: 0)
    }
    for (index, button) in featureBtn.enumerated() {
      if let key = keys.safeValue(at: index) {
        button.setTitle(Text.localizedString(key), for: .normal)
      } else {
        button.isHidden = true
      }
    }
  }

  override func setupView() {
    addNavigation(title: Text.localizedString("GoldInfoDetail.NaviTitle"))
    setupTbView()
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
