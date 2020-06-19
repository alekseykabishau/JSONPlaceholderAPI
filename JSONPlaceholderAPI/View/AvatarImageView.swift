//
//  AvatarImageView.swift
//  JSONPlaceholderAPI
//
//  Created by Aleksey on 0608..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {

	let placeholder = UIImage(systemName: "person")
	
	override func awakeFromNib() {
		super.awakeFromNib()
		configure()
	}
	
	
	private func configure() {
		layer.cornerRadius = 15
		clipsToBounds = true
	}
	
	
	func downloadAvatar(fromURL url: String) {
		NetworkManager.shared.downloadImage(from: url) { [weak self] image in
			guard let self = self else { return }
			if let image = image {
				DispatchQueue.main.async { self.image = image }
			} else {
				DispatchQueue.main.async { self.image = self.placeholder }
				return
			}
		}
	}
}
