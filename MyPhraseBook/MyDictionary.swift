//
//  MyDictionary.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 09..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class MyDictionary: NSObject, NSCoding, NSCopying{

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
    
    public func randomizeForTestOut(){
        for translation in translations{
            translation.setRandomToAsk()
        }
    }
    
    public func getDictionaryID() -> String{
        return self.sourceLanguageCode + "::" + self.targetLanguageCode
    }
    
    public func getArchiveUrl() -> URL{
        return PersistenceHelper.PhraseBooksDirectory.appendingPathComponent(getDictionaryID())
    }
    
    public func getDisplayName() -> String{
        return sourceLanguageName + " - " + targetLanguageName
    }
    
    public func getShareString() -> String {
        var output: String = ""
        output = output + "[[[ " + getDisplayName() + " ]]]" + "\n[[[ " + getDictionaryID() + " ]]]" + "\n" + "--------------------------------------" + "\n"
        var lineNumber = 1
        for translation in translations{
            output = output + String(lineNumber) + ": " + translation.sourceTranslation + " ~~~ " + translation.targetTranslation + "\n"
            lineNumber = lineNumber + 1
        }
        output = output + "--------------------------------------"
        return output
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
            Utils.log("Unable to decode the name for a sourceLanguageCode object.")
            return nil
        }
        guard let targetLanguageCode = aDecoder.decodeObject(forKey: PropertyKey.targetLanguageCode) as? String else {
            Utils.log("Unable to decode the name for a targetLanguageCode object.")
            return nil
        }
        guard let sourceLanguageName = aDecoder.decodeObject(forKey: PropertyKey.sourceLanguageName) as? String else {
            Utils.log("Unable to decode the name for a sourceLanguageName object.")
            return nil
        }
        guard let targetLanguageName = aDecoder.decodeObject(forKey: PropertyKey.targetLanguageName) as? String else {
            Utils.log("Unable to decode the name for a targetLanguageName object.")
            return nil
        }
        
        guard let translations = aDecoder.decodeObject(forKey: PropertyKey.translations) as? [Translation] else {
            Utils.log("Unable to decode the name for a translations object.")
            return nil
        }
        
        // Must call designated initializer.
        self.init(sourceLanguageCode: sourceLanguageCode, targetLanguageCode: targetLanguageCode, sourceLanguageName: sourceLanguageName, targetLanguageName: targetLanguageName, translations: translations)
        
    }
    
    // MARK: NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        return type(of:self).init(self)
    }
    
    required init(_ dictionary: MyDictionary) {
        sourceLanguageCode = dictionary.sourceLanguageCode
        targetLanguageCode = dictionary.targetLanguageCode
        sourceLanguageName = dictionary.sourceLanguageName
        targetLanguageName = dictionary.targetLanguageName
        translations = [Translation]()
        for translation in dictionary.translations {
            translations.append(Translation(translation))
        }
    }

    
    
}
