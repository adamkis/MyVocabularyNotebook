//
//  Utils.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 16..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit
import os.log

class Utils: NSObject {

    open class func log(_ input: StaticString){
        os_log(input, log: OSLog.default, type: .default)
    }
    
    open class func print(_ items: Any...){
        print(items)
    }
}
