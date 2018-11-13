//
//  VisitTableViewCell.swift
//  Test iOS
//
//  Created by Grisha Okin on 09/11/2018.
//  Copyright © 2018 Grisha Okin. All rights reserved.
//

import UIKit

class VisitTableViewCell: UITableViewCell {

    var delegate: VisitsTableViewControllerSortable!
    
    @IBOutlet var mainTextLabel: UILabel!
    @IBOutlet var uiSwitch: UISwitch!
    
    @IBAction func sortingValueChanged(_ sender: UISwitch) {
        let value = sender.isOn
        delegate.sortVisits(value)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
