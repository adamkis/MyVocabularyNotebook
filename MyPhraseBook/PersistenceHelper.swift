//
//  UserDefaultsHelper.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 16..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class PersistenceHelper: NSObject {

    static let SELECTED_DICTIONARY_KEY = "SELECTED_DICTIONARY_KEY"
    
    // Root document directory - currently unused
    static let PhraseBooksDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    // PhraseBooks sirectory
//    static let PhraseBooksDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("PhraseBooks")
    
    
    // MARK: User Defaults
    
    open class func saveSelectedDictionaryId(myDictionary: MyDictionary){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(myDictionary.getDictionaryID(), forKey: SELECTED_DICTIONARY_KEY)
        userDefaults.synchronize()
        Utils.print("Saved dictionary: Source lang: \(myDictionary.sourceLanguageName), Target Lang: \(myDictionary.targetLanguageName), Dict object: \(myDictionary)")
    }
    
    
    open class func loadSelectedDictionaryId() -> String?{
        let userDefaults = UserDefaults.standard
        return userDefaults.value(forKey: SELECTED_DICTIONARY_KEY) as? String
    }
    
    open class func printAllUserDefaults(){
        Utils.log("Printing User Defaults")
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            Utils.print("\(key) = \(value) \n")
        }
        Utils.log("Printing User Defaults - end")
    }
    
    // MARK: Storing in files - NSKeyedArchiver
    
    open class func saveDictionary(selectedDictionary: MyDictionary) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(selectedDictionary, toFile: selectedDictionary.getArchiveUrl().path)
        if isSuccessfulSave {
            Utils.log("Translations successfully saved.")
        } else {
            Utils.log("Failed to save translations...")
        }
    }
    
    open class func getArchiveUrl(dictionaryId: String!) -> URL {
        return PhraseBooksDirectory.appendingPathComponent(dictionaryId)
    }
    
    
    open class func loadDictionary(url: URL) -> MyDictionary?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? MyDictionary
    }
    
    
    open class func loadDictionary(dictionaryId: String) -> MyDictionary?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: getArchiveUrl(dictionaryId: dictionaryId).path) as? MyDictionary
    }
    
    open class func getAllDictionaries() -> [MyDictionary]{
        var myDictionaries = [MyDictionary]()
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: PhraseBooksDirectory, includingPropertiesForKeys: nil, options: [])
            for url in directoryContents{
                let myDictionary: MyDictionary? = PersistenceHelper.loadDictionary(url: url)
                if( myDictionary != nil ){
                    myDictionaries.append(myDictionary!)
                }
            }
        } catch let error as NSError {
            Utils.print(error.localizedDescription)
        }
        return myDictionaries
    }
    
    open class func printAllFilesInDirectory(){
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            Utils.print("Printing all files in Document Directory")
            Utils.print(directoryContents)
            Utils.print("Printing all files in Document Directory - end")
            
        } catch let error as NSError {
            Utils.print(error.localizedDescription)
        }
    }
    
    
    
}