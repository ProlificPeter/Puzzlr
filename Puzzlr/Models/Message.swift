//
//  Response.swift
//  Puzzlr
//
//  Created by Peter Granlund on 1/5/22.
//

import Foundation

struct Response: Codable, Hashable {
	var messages: [Message]
}

struct Message: Codable, Hashable {
	var message: String
	var isAvailable: Bool
}
