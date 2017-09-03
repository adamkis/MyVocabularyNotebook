//
//  Translation.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 01..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class Translation: NSObject {

    // MARK: Properties
    var sourceTranslation: String
    var targetTranslation: String
//    var session: String!
//    var priority: Int!
//    var color: UIColor!
    
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
    
}
