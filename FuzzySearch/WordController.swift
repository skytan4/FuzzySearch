//
//  WordController.swift
//  FuzzySearch
//
//  Created by Skyler Tanner on 12/10/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import Foundation


class WordController {
    var words: [Word] = []
    
    static let sharedInstance = WordController()
    
    init() {
        self.words = []
        if let path = NSBundle.mainBundle().pathForResource("dictionary", ofType: "json") {
            
            if let jsonData = NSData(contentsOfFile: path) {
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? [String: String]
                    {
                        for (key, value) in jsonResult {
                            let wordObject = Word(key: key, value: value)
                            self.words.append(wordObject)
                        }
                    }
                }catch {
                    print("ERROR SERIALIZING OBJECTS")
                }
            }
        }
        self.words = self.words.sort { (word1, word2) -> Bool in
            return word1.name < word2.name
        }
    }
    
    static func fuzzySearch(var originalString: String, var stringToSearch: String, caseSensitive: Bool = false)->Bool {
        
        if originalString.characters.count == 0 || stringToSearch.characters.count == 0 {
            return false
        }
        
        if originalString.characters.count < stringToSearch.characters.count {
            return false
        }
        
        if !caseSensitive {
            originalString = originalString.lowercaseString
            stringToSearch = stringToSearch.lowercaseString
        }
        
        var searchIndex : Int = 0
        
        for charOut in originalString.characters {
            for (indexIn, charIn) in stringToSearch.characters.enumerate() {
                if indexIn == searchIndex{
                    if charOut == charIn{
                        searchIndex++
                        if searchIndex == stringToSearch.characters.count {
                            return true;
                        }
                        else {
                            break
                        }
                    }
                    else {
                        break
                    }
                }
            }
        }
        return false;
    }
    
}