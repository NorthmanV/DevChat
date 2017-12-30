//
//  UserCell.swift
//  DevChat
//
//  Created by Руслан Акберов on 28.12.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckmark(selected: false)
    }
    
    func updateUI(user: User) {
        firstNameLabel.text = user.firstName
    }

    func setCheckmark(selected: Bool) {
        let imageString = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageString))
    }

}
