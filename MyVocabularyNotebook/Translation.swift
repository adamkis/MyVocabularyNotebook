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
    var session: String!
    var priority: Int!
    var color: UIColor!
    
    init(sourceTranslation: String, targetTranslation: String, session: String?){
        self.sourceTranslation = sourceTranslation
        self.targetTranslation = targetTranslation
        self.session = session!
    }
    
}
