//
//  UserCell.swift
//  JSONPlaceholderAPI
//
//  Created by Aleksey on 0607..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

	@IBOutlet weak var avatarView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
    }
	
	
	func set(user: User) {
		avatarView.image = UIImage(named: "Aleksey")
		nameLabel.text = user.username
	}

	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
