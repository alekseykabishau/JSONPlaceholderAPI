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
	
	
	//https://fakejson.com/documentation#introduction
	// at glance more advanced fake api
	// use url components
	
	func getUsers() {
		let stringAddress = "https://jsonplaceholder.typicode.com/users"
		guard let url = URL(string: stringAddress) else { print("return there"); return }
		let session = URLSession.shared
		let dataTask = session.dataTask(with: url) { (data, response, error) in
			
			if let error = error {
				print("error: \(error)")
				return
			}
			
			if let response = response as? HTTPURLResponse {
				print(response.statusCode)
			}
			
			if let data = data {
				do {
					let userData = try JSONDecoder().decode([User].self, from: data)
					self.users = userData
					
					DispatchQueue.main.async { self.tableView.reloadData() }
				} catch {
					print(error.localizedDescription)
				}
			}
		}
		dataTask.resume()
	}
}

extension UsersVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let user = users[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = user.name
		cell.detailTextLabel?.text = user.address.city
		return cell
	}
}

extension UsersVC: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(users[indexPath.row])
	}
}
