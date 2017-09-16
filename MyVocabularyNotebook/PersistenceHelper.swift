//
//  UserDefaultsHelper.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 16..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class PersistenceHelper: NSObject {

    static let DICTIONARY_KEY = "DICTIONARY_KEY"
    
    open class func saveSelectedDictionaryId(myDictionary: MyDictionary){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(myDictionary.getDictionaryID(), forKey: DICTIONARY_KEY)
        userDefaults.synchronize()
        print("Saved dictionary: Source lang: \(myDictionary.sourceLanguageName), Target Lang: \(myDictionary.targetLanguageName), Dict object: \(myDictionary)")
    }
    
    
    open class func loadSelectedDictionaryId() -> String?{
        let userDefaults = UserDefaults.standard
        return userDefaults.value(forKey: DICTIONARY_KEY) as? String
    }
    
    open class func printAllUserDefaults(){
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
    }
    
    
}
