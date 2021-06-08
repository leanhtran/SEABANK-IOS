//
//  SBSVerifyBuyInfoVC.swift
//  SBGold
//
//  Created by Anonymos on 2021/06/07.
//

import UIKit

class SBSVerifyBuyInfoVC: SBSGoldBaseVC {
  @IBOutlet weak private var tbView: UITableView!
  @IBOutlet weak private var nextBtn: UIButton!
  
  struct DataSource {
    var title: String
    var value: String
  }
  
  private var datas: [DataSource] = [] {
    didSet {
      tbView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    datas.append(DataSource(title: Text.localizedString("BGVI.Account"), value: "A123445667"))
    datas.append(DataSource(title: Text.localizedString("BGVI.FullName"), value: "NGUYEN VAN A"))
    datas.append(DataSource(title: Text.localizedString("BGVI.TransactionPlace"), value: "PGD Vạn Xuân - 38 Yết Kiêu - Hoàn Kiếm"))
    datas.append(DataSource(title: Text.localizedString("BGVI.GoldType"), value: "Vàng JSC"))
    datas.append(DataSource(title: Text.localizedString("BGVI.Quantity"), value: "2 chỉ"))
    datas.append(DataSource(title: Text.localizedString("BGVI.Price"), value: "5,500,000 VND"))
    datas.append(DataSource(title: Text.localizedString("BGVI.Amount"), value: "11,000,000 VND"))
    
    datas.append(DataSource(title: Text.localizedString("BGVI.DeleveryForm"), value: "Hẹn trả"))
    datas.append(DataSource(title: Text.localizedString("BGVI.AppointmentDate"), value: "12/12/2020"))
    datas.append(DataSource(title: Text.localizedString("BGVI.TransactionClassify"), value: "Mua sắm"))
    datas.append(DataSource(title: Text.localizedString("BGVI.PromotionCode"), value: "SEABANK1234"))
    
    datas.append(DataSource(title: Text.localizedString("BGVI.ReferUserInfo"), value: "0972xxxxxx\nNGUYEN VAN B"))
    datas.append(DataSource(title: Text.localizedString("BGVI.TransactionDate"), value: "12/12/2020"))
  }
  
  override func setupView() {
    addNavigation(title: Text.localizedString("BGVI.NaviTitle"))
    setupMultiLanguage()
    setupCommon()
    setupTbView()
  }
  
  private func setupCommon() {
    addObservable(buttons: [nextBtn])
  }
  
  override func didTapButton(_ btn: UIButton) {
    // TODO next
  }
  
  private func setupMultiLanguage() {
    nextBtn.setTitle(Text.localizedString("Button.Continue"), for: .normal)
  }
  
  private func setupTbView() {
    tbView.register(SBSFormInfoCell.self)
    tbView.delegate = self
    tbView.dataSource = self
  }
}

extension SBSVerifyBuyInfoVC: UITableViewDelegate, UITableViewDataSource {
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
