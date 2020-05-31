//
//  User.swift
//  JSONPlaceholderAPI
//
//  Created by Aleksey on 0524..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

struct User: Decodable {
	let id: Int
	let name: String
	let username: String
	let email: String
	let address: Address
	let phone: String
	let website: String
	let company: Company
}

struct Address: Decodable {
	let street: String
	let suite: String
	let city: String
	let zipcode: String
	//let geo: ???
}

struct Company: Decodable {
	let name: String
	let catchPhrase: String
	let bsValue: String
	
	private enum CodingKeys: String, CodingKey {
		case name
		case catchPhrase
		case bsValue = "bs"
	}
}
/*
{
	"id": 3,
	"name": "Clementine Bauch",
	"username": "Samantha",
	"email": "Nathan@yesenia.net",
	"address": {
		"street": "Douglas Extension",
		"suite": "Suite 847",
		"city": "McKenziehaven",
		"zipcode": "59590-4157",
		"geo": {
			"lat": "-68.6102",
			"lng": "-47.0653"
		}
	},
	"phone": "1-463-123-4447",
	"website": "ramiro.info",
	"company": {
		"name": "Romaguera-Jacobson",
		"catchPhrase": "Face to face bifurcated interface",
		"bs": "e-enable strategic applications"
	}
}
*/
