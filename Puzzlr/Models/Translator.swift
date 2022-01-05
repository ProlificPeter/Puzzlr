//
//  Translator.swift
//  Puzzlr
//
//  Created by prlg on 1/4/22.
//

import Foundation

struct Translator {
    var codeTranslation: String = "dummy text"
    var foundCode: String = ""
    
    func translateCode(input: String) -> (Bool, String){
        
        let codeDictionary = [
            "5401" : "Remake this candle, together, with another set of codes.",
            "7H62" : "North Shore Trip",
            "Q13X" : "Rock ________; We will do something rock related, Together",
            "62CX" : "Private Saint Dinette Dinner",
            "C117" : "Custom DnD One-Shot, private or for whomever you choose to join.",
            "R4N7" : "Theme-Specific Playlist (You determine the theme)",
            "G431" : "ANY Book Of Your Choosing; First edition, signed, etc.",
            "EX47" : "$100 Theme Question; Time to actually pick what that $100 purchase is, and do it.",
            "Y43M" : "Cocktail Party"
        ]
		
		if let translation = codeDictionary[input]
		{
			return (true, translation)
		}
		else {
			return (false, "Invalid Code")
		}
        
    }
}
