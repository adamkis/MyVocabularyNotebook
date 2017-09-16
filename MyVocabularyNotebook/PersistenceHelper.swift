//
//  UserDefaultsHelper.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 16..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit
import os.log

class PersistenceHelper: NSObject {

    static let DICTIONARY_KEY = "DICTIONARY_KEY"
    
    // MARK: User Defaults
    
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
    
    // MARK: Storing in files - NSKeyedArchiver
    
    open class func saveDictionary(selectedDictionary: MyDictionary) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(selectedDictionary, toFile: selectedDictionary.getArchiveUrl().path)
        if isSuccessfulSave {
            os_log("Translations successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save translations...", log: OSLog.default, type: .error)
        }
    }
    
    open class func getArchiveUrl(dictionaryId: String!) -> URL {
        let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        return DocumentsDirectory.appendingPathComponent(dictionaryId)
    }
    
    open class func loadDictionary(dictionaryId: String) -> MyDictionary?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: getArchiveUrl(dictionaryId: dictionaryId).path) as? MyDictionary
    }
    
    
    
}
