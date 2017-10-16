//
//  Translation.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 01..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class Translation: NSObject, NSCoding, NSCopying {

    // MARK: Properties
    var sourceTranslation: String
    var targetTranslation: String
//    var session: String!
//    var priority: Int!
//    var color: UIColor!

    //MARK: Types
    struct PropertyKey {
        static let sourceTranslation = "sourceTranslation"
        static let targetTranslation = "targetTranslation"
    }
    
    init?(sourceTranslation: String?, targetTranslation: String?){
        self.sourceTranslation = sourceTranslation!
        self.targetTranslation = targetTranslation!
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sourceTranslation, forKey: PropertyKey.sourceTranslation)
        aCoder.encode(targetTranslation, forKey: PropertyKey.targetTranslation)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let sourceTranslation = aDecoder.decodeObject(forKey: PropertyKey.sourceTranslation) as? String else {
            Utils.log("Unable to decode the name for a translation object.")
            return nil
        }
        let targetTranslation = aDecoder.decodeObject(forKey: PropertyKey.targetTranslation) as? String
        // Must call designated initializer.
        self.init(sourceTranslation: sourceTranslation, targetTranslation: targetTranslation)
    }
    
    // MARK: NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        return type(of:self).init(self)
    }
    
    required init(_ translation: Translation) {
        sourceTranslation = translation.sourceTranslation
        targetTranslation = translation.targetTranslation
    }

}
