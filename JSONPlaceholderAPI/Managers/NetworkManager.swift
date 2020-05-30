//
//  NetworkManager.swift
//  JSONPlaceholderAPI
//
//  Created by Aleksey on 0529..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

class NetworkManager {
	
	static let shared = NetworkManager()
	
	//https://fakejson.com/documentation#introduction
	// at glance more advanced fake api
	// use url components
	let baseURL = "https://jsonplaceholder.typicode.com"
	
	private init() { }
	
	func getAllUsers(completed: @escaping (Result<[User], JPAError>) -> Void) {
		print(#function)
		let endPoint = baseURL + "/users"
		
		guard let url = URL(string: endPoint) else {
			completed(.failure(.invalidData))
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error {
				completed(.failure(.unableToComplete))
				print("error")
				return
			}
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completed(.failure(.invalidResponse))
				print("response")
				return
			}
			
			guard let data = data else {
				completed(.failure(.invalidData))
				print("data")
				return
			}
			
			do {
				let users = try JSONDecoder().decode([User].self, from: data)
				completed(.success(users))
			} catch {
				print("error decoding")
				completed(.failure(.invalidData))
			}
		}
		task.resume()
	}
}
