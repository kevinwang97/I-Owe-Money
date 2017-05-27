//
//  MyCell.swift
//  I Owe Money
//
//  Created by Kevin on 2017-05-23.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
