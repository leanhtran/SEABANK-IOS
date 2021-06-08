//
//  SBSGoldInfoCell.swift
//  SBGold
//
//  Created by Anonymos on 08/06/2021.
//

import UIKit

class SBSGoldInfoCell: SBSGoldTableViewCell {
  @IBOutlet weak private var goldTypeLb: UILabel!
  @IBOutlet weak private var contractLb: UILabel!
  @IBOutlet weak private var deliveryFormLb: UILabel!
  @IBOutlet weak private var buyDateLb: UILabel!
  @IBOutlet weak private var dueDateLb: UILabel!
  @IBOutlet weak private var quantityLb: UILabel!
  
  @IBOutlet weak private var goldTypeValueLb: UILabel!
  @IBOutlet weak private var contractValueLb: UILabel!
  @IBOutlet weak private var deliveryFormValueLb: UILabel!
  @IBOutlet weak private var buyDateValueLb: UILabel!
  @IBOutlet weak private var dueDateValueLb: UILabel!
  @IBOutlet weak private var quantityValueLb: UILabel!
  
  override func setupView() {
    goldTypeLb.text = Text.localizedString("GoldInfo.GoldType")
    contractLb.text = Text.localizedString("GoldInfo.ContractNumber")
    deliveryFormLb.text = Text.localizedString("GoldInfo.DeliveryForm")
    buyDateLb.text = Text.localizedString("GoldInfo.BuyDate")
    dueDateLb.text = Text.localizedString("GoldInfo.DueDate")
    quantityLb.text = Text.localizedString("GoldInfo.Quantity")
  }
}
