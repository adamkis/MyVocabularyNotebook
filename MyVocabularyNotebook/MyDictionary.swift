//
//  MyDictionary.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 09..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit
import os.log

class MyDictionary: NSObject, NSCoding{

    // MARK: Properties
    var sourceLanguageCode: String
    var targetLanguageCode: String
    var sourceLanguageName: String
    var targetLanguageName: String
    var translations: [Translation]
    
    //MARK: Types
    struct PropertyKey {
        static let sourceLanguageCode = "sourceLanguageCode"
        static let targetLanguageCode = "targetLanguageCode"
        static let sourceLanguageName = "sourceLanguageName"
        static let targetLanguageName = "targetLanguageName"
        static let translations = "translations"
    }
    
    //MARK: Archiving Paths
    var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    init(sourceLanguageCode: String?, targetLanguageCode: String?, sourceLanguageName: String?, targetLanguageName: String?, translations: [Translation]?){
        self.sourceLanguageCode = sourceLanguageCode!
        self.targetLanguageCode = targetLanguageCode!
        self.sourceLanguageName = sourceLanguageName!
        self.targetLanguageName = targetLanguageName!
        if( translations == nil ){
            self.translations = [Translation]()
        }
        else{
            self.translations = translations!
        }
    }
    
    public func getDictionaryID() -> String{
        return self.sourceLanguageCode + "::" + self.targetLanguageCode
    }
    
    public func getArchiveUrl() -> URL{
        return DocumentsDirectory.appendingPathComponent(getDictionaryID())
    }
    
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sourceLanguageCode, forKey: PropertyKey.sourceLanguageCode)
        aCoder.encode(targetLanguageCode, forKey: PropertyKey.targetLanguageCode)
        aCoder.encode(sourceLanguageName, forKey: PropertyKey.sourceLanguageName)
        aCoder.encode(targetLanguageName, forKey: PropertyKey.targetLanguageName)
        aCoder.encode(translations, forKey: PropertyKey.translations)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let sourceLanguageCode = aDecoder.decodeObject(forKey: PropertyKey.sourceLanguageCode) as? String else {
            os_log("Unable to decode the name for a sourceLanguageCode object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let targetLanguageCode = aDecoder.decodeObject(forKey: PropertyKey.targetLanguageCode) as? String else {
            os_log("Unable to decode the name for a targetLanguageCode object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let sourceLanguageName = aDecoder.decodeObject(forKey: PropertyKey.sourceLanguageName) as? String else {
            os_log("Unable to decode the name for a sourceLanguageName object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let targetLanguageName = aDecoder.decodeObject(forKey: PropertyKey.targetLanguageName) as? String else {
            os_log("Unable to decode the name for a targetLanguageName object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let translations = aDecoder.decodeObject(forKey: PropertyKey.translations) as? [Translation] else {
            os_log("Unable to decode the name for a translations object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(sourceLanguageCode: sourceLanguageCode, targetLanguageCode: targetLanguageCode, sourceLanguageName: sourceLanguageName, targetLanguageName: targetLanguageName, translations: translations)
        
    }
    
    
    
}