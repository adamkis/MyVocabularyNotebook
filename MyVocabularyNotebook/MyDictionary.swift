//
//  MyDictionary.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 09..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class MyDictionary: NSObject {

    // MARK: Properties
    var sourceLanguageCode: String
    var targetLanguageCode: String
    var sourceLanguageName: String
    var targetLanguageName: String
    var translations: [Translation]
    
    //MARK: Archiving Paths
    var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    init(sourceLanguageCode: String?, targetLanguageCode: String?, sourceLanguageName: String?, targetLanguageName: String?){
        self.sourceLanguageCode = sourceLanguageCode!
        self.targetLanguageCode = targetLanguageCode!
        self.sourceLanguageName = sourceLanguageName!
        self.targetLanguageName = targetLanguageName!
        translations = [Translation]()
    }
    
    public func getDictionaryID() -> String{
        return self.sourceLanguageCode + "///" + self.targetLanguageCode
    }
    
    public func getArchiveUrl() -> URL{
        return DocumentsDirectory.appendingPathComponent(getDictionaryID())
    }
    
    
}
