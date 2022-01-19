//
//  Translation.swift
//  Puzzlr
//
//  Created by Peter Granlund on 1/19/22.
//

import Foundation

struct Map: Codable, Hashable {
	var translations: [Translation]
}

struct Translation: Codable, Hashable {
	var code: String
	var reward: String
}
