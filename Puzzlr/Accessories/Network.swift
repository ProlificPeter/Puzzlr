//
//  Network.swift
//  Puzzlr
//
//  Created by prlg on 1/19/22.
//

import Foundation

class Network {
	
	func getResponses(completion: @escaping (Result<[Message], Error>) -> Void) {
		guard let url = URL(string: K.URLS.RESPONSE_URL) else {
			print("invalid URL"); return
		}
		
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error.localizedDescription as! Error))
				return
			}
			do {
				let messages = try JSONDecoder().decode([Message].self, from: data!)
				completion(.success(messages))
				if !messages.isEmpty {
					print(messages[0].message)
					}
				} catch {
					print(error)
			}
		}.resume()
	}
		
	func getTranslations(completion: @escaping (Result<[String : String], Error>) -> Void) {
		
		guard let url = URL(string: K.URLS.TRANSLATION_URL) else {
			print("Invalid URL")
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error.localizedDescription as! Error))
				return
			}
			do {
				let rewards = try JSONDecoder().decode([String : String].self, from: data!)
				completion(.success(rewards))
				if !rewards.isEmpty {
					print("success")
					}
				} catch {
					print(error)
			}
		}.resume()
		
		
		
		/*guard let url = URL(string: K.URLS.RESPONSE_URL) else {
			print("invalid URL"); return
		}
		
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error.localizedDescription as! Error))
				return
			}
			do {
				let rewards = try JSONDecoder().decode([Translation].self, from: data!)
				completion(.success(rewards))
				if !rewards.isEmpty {
					print(rewards[0].reward)
					}
				} catch {
					print(error)
			}
		}.resume()*/
	}
}
