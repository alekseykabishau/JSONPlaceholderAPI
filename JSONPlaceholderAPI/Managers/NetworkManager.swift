//
//  NetworkManager.swift
//  JSONPlaceholderAPI
//
//  Created by Aleksey on 0529..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class NetworkManager {
	
	static let shared = NetworkManager()
	
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
	
	
	func downloadImage(from stringURL: String, completed: @escaping (UIImage?) -> Void) {
		
		guard let url = URL(string: stringURL) else {
			completed(nil)
			return
		}
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			// weak self ???
			// caching images???
			// intentianally not handling error because using placeholder in case of issue
			guard
				error == nil,
				let response = response as? HTTPURLResponse,
				response.statusCode == 200,
				let data = data,
				let image = UIImage(data: data) else {
					completed(nil)
					return
			}
			completed(image)
		}.resume()
	}
}
