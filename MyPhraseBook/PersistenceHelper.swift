//
//  UserDefaultsHelper.swift
//  MyPhraseBook
//
//  Created by Adam on 2017. 09. 16..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class PersistenceHelper: NSObject {

    static let SELECTED_PHRASEBOOK_KEY = "SELECTED_PHRASEBOOK_KEY"
    
    // Root document directory - currently unused
    static let PhraseBookListDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    // PhraseBookList sirectory
//    static let PhraseBookListDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("PhraseBookList")
    
    
    // MARK: User Defaults
    
    open class func saveSelectedPhraseBookId(phraseBook: PhraseBook){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(phraseBook.getPhraseBookID(), forKey: SELECTED_PHRASEBOOK_KEY)
        userDefaults.synchronize()
        Utils.print("Saved PhraseBook: Source lang: \(phraseBook.sourceLanguageName), Target Lang: \(phraseBook.targetLanguageName), Dict object: \(phraseBook)")
    }
    
    
    open class func loadSelectedPhraseBookId() -> String?{
        let userDefaults = UserDefaults.standard
        return userDefaults.value(forKey: SELECTED_PHRASEBOOK_KEY) as? String
    }
    
    open class func printAllUserDefaults(){
        Utils.log("Printing User Defaults")
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            Utils.print("\(key) = \(value) \n")
        }
        Utils.log("Printing User Defaults - end")
    }
    
    // MARK: Storing in files - NSKeyedArchiver
    
    open class func savePhraseBook(phraseBook: PhraseBook) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(phraseBook, toFile: phraseBook.getArchiveUrl().path)
        if isSuccessfulSave {
            Utils.log("Translations successfully saved.")
        } else {
            Utils.log("Failed to save translations...")
        }
    }
    
    open class func getArchiveUrl(phraseBookId: String!) -> URL {
        return PhraseBookListDirectory.appendingPathComponent(phraseBookId)
    }
    
    
    open class func loadPhraseBook(url: URL) -> PhraseBook?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? PhraseBook
    }
    
    
    open class func loadPhraseBook(phraseBookId: String) -> PhraseBook?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: getArchiveUrl(phraseBookId: phraseBookId).path) as? PhraseBook
    }
    
    open class func getPhraseBookList() -> [PhraseBook]{
        var phraseBookList = [PhraseBook]()
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: PhraseBookListDirectory, includingPropertiesForKeys: nil, options: [])
            for url in directoryContents{
                let phraseBook: PhraseBook? = PersistenceHelper.loadPhraseBook(url: url)
                if( phraseBook != nil ){
                    phraseBookList.append(phraseBook!)
                }
            }
        } catch let error as NSError {
            Utils.print(error.localizedDescription)
        }
        return phraseBookList
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
