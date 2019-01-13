//
//  SelectKidsTableViewCell.swift
//  kaPu
//
//  Created by Emily Tan on 12/6/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit

class SelectKidsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkBox: UIImageView!
    var checked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
