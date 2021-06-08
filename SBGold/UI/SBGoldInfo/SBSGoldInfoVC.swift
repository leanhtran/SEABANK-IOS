//
//  SBSGoldInfoVC.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit

class SBSGoldInfoVC: SBSGoldBaseVC {
  @IBOutlet weak private var tbView: UITableView!
  @IBOutlet weak private var slideLeadingSpace: NSLayoutConstraint!
  @IBOutlet private var optionsBtn: [UIButton]!
  
  enum DepositFrom {
    case online
    case counter
    
    var header: String {
      switch self {
      case .online:
        return Text.localizedString("GoldInfo.Menu.Online")
      case .counter:
        return Text.localizedString("GoldInfo.Menu.Counter")
      }
    }
    
    var footer: String {
      switch self {
      case .online:
        return Text.localizedString("GoldInfo.TotalGoldOnline")
      case .counter:
        return Text.localizedString("GoldInfo.TotalGoldCounter")
      }
    }
  }

  struct DataSource {
    var form: DepositFrom
    var datas: [SBSGold]
  }
  
  var dataSources: [DataSource] = [] {
    didSet {
      tbView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    didTapButton(optionsBtn[0])
  }
  
  override func setupView() {
    addObservable(buttons: optionsBtn)
    setupTbView()
    addNavigation(title: Text.localizedString("GoldInfo.NaviTitle"))
    setupViewCommon()
    setupMenuUI()
  }
  
  private func setupViewCommon() {
    view.backgroundColor = bgColor
  }
  
  private func setupTbView() {
    Apply(tbView!) {
      $0.register(SBSGoldInfoCell.self)
      $0.delegate = self
      $0.dataSource = self
      $0.tableFooterView = UIView()
      $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
    }
  }
  
  private func setupMenuUI() {
    let keys = ["GoldInfo.Menu.All", "GoldInfo.Menu.Online", "GoldInfo.Menu.Counter"]
    for (index, button) in optionsBtn.enumerated() {
      button.setTitle(Text.localizedString(keys[index]), for: .normal)
    }
  }
  
  override func didTapButton(_ btn: UIButton) {
    for (index, button) in optionsBtn.enumerated() {
      let isSelected = btn == button
      if isSelected {
        UIView.animate(withDuration: 0.1) {
          self.slideLeadingSpace.constant = btn.bounds.width * CGFloat(index) + 5
          self.view.layoutIfNeeded()
        }
        updateData(index)
      }
    }
  }
  
  private func updateData(_ index: Int) {
    let online = DataSource(form: .online, datas: [SBSGold(), SBSGold()])
    let counter = DataSource(form: .counter, datas: [SBSGold()])
    switch index {
    case 0:
      dataSources = [online, counter]
    case 1:
      dataSources = [online]
    case 2:
      dataSources = [counter]
    default:
      break
    }
  }
}

extension SBSGoldInfoVC: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return dataSources.count == 2 ? 3 : dataSources.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let datas = dataSources.safeValue(at: section)?.datas else { return 0 }
    return datas.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tbView.dequeue(SBSGoldInfoCell.self)
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = SBSGoldInfoHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    guard let item = dataSources.safeValue(at: section) else {
      header.setTitle(text: Text.localizedString("GoldInfo.TotalGold"))
      header.backgroundColor = .clear
      return header
    }
    header.setTitle(text: item.form.header)
    return header
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let item = dataSources.safeValue(at: section) else { return nil }
    let footer = SBSGoldInfoFooter(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    footer.setTitle(text: item.form.footer)
    return footer
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    SBSCoordinator.shared.moveTo(Route.goldInfoDetail)
  }
}
