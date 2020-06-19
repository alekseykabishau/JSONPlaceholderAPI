//
//  UserCell.swift
//  JSONPlaceholderAPI
//
//  Created by Aleksey on 0607..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

	static let reuseIdentifier = String(describing: UserCell.self)
	
	@IBOutlet weak var avatarView: AvatarImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet var activityIndicator: UIActivityIndicatorView!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
    }
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		avatarView.image = nil
	}
	
	
	func set(user: User) {
		nameLabel.text = user.username
		
		Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
			self.avatarView.downloadAvatar(fromURL: user.avatarStringURL)
		})
	}
}
