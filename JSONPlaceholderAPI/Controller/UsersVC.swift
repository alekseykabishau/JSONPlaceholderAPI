//
//  UsersVC.swift
//  JSONPlaceholderAPI
//
//  Created by Aleksey on 0524..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var users = [User]()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		
		title = "Users"
		getUsers()
	}
	

	func getUsers() {
		NetworkManager.shared.getAllUsers { [weak self] result in
			guard let self = self else { return }
			switch result {
				case .success(let users):
					self.users = users
					DispatchQueue.main.async {
						self.tableView.reloadData()
				}
				case .failure(let error):
					print(error.localizedDescription)
			}
		}
	}
}

extension UsersVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let user = users[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as! UserCell
		cell.set(user: user)
		return cell
	}
}

extension UsersVC: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(users[indexPath.row])
	}
}
