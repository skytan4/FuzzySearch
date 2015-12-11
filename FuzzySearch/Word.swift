//
//  Word.swift
//  FuzzySearch
//
//  Created by Skyler Tanner on 12/9/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import Foundation

class Word {
    let name: String?
    let definition: String?
    let firstLetter: String?
    
    init(key:String, value: String){
        name = key
        definition = value
        if let wordFirstLetter = key.characters.first {
            firstLetter = "\(wordFirstLetter)"
        } else {
            firstLetter = ""
        }
    }
}