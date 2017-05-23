//
//  MyCell.swift
//  I Owe Money
//
//  Created by Kevin on 2017-05-23.
//  Copyright © 2017 Kevin. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
