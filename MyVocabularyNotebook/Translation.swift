//
//  Translation.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 01..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit
import os.log

class Translation: NSObject, NSCoding {

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
//        self.session = session!
//        self.priority = priority!
//        self.color = color!
    }
    
//    init?(name: String, photo: UIImage?, rating: Int) {
//        
//        // Initialization should fail if there is no name or if the rating is negative.
//        if name.isEmpty || rating < 0  {
//            return nil
//        }
//        
//        // Initialize stored properties.
//        self.name = name
//        self.photo = photo
//        self.rating = rating
//        
//    }
    
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sourceTranslation, forKey: PropertyKey.sourceTranslation)
        aCoder.encode(targetTranslation, forKey: PropertyKey.targetTranslation)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let sourceTranslation = aDecoder.decodeObject(forKey: PropertyKey.sourceTranslation) as? String else {
            os_log("Unable to decode the name for a translation object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
//        let sourceTranslation = aDecoder.decodeObject(forKey: PropertyKey.sourceTranslation) as? String
        let targetTranslation = aDecoder.decodeObject(forKey: PropertyKey.targetTranslation) as? String
        
        // Must call designated initializer.
        self.init(sourceTranslation: sourceTranslation, targetTranslation: targetTranslation)
        
    }
    
}
