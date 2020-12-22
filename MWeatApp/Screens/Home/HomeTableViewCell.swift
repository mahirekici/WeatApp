//
//  HomeTableViewCell.swift
//  MWeatApp
//
//  Created by mahir ekici on 19.12.2020.
//  Copyright © 2020 mahi rekici. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    

    @IBOutlet  weak var cityLabel: UILabel?
    
    static let identifier = "HomeCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}
