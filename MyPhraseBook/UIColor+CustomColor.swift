//
//  UIColor+CustomColor.swift
//  MyPhraseBook
//
//  Created by Adam on 2017. 10. 09..
//  Copyright © 2017. Adam. All rights reserved.
//
// Copied from here : https://stackoverflow.com/questions/33942483/swift-extension-example

import UIKit

extension UIColor {
    
    class var customTurquoise: UIColor {
        // Original
//        let turquoise = 0x42f4df
        let turquoise = 0x0bc1ac
        return UIColor.rgb(fromHex: turquoise)
    }
    
    class var customTurquoiseDark: UIColor {
        let darkTurquoise = 0x089181
        return UIColor.rgb(fromHex: darkTurquoise)
    }
    
    class var customTurquoiseLight: UIColor {
        let lightTurquoise = 0x0febd1
        return UIColor.rgb(fromHex: lightTurquoise)
    }
    
    class var customRedViolet: UIColor {
        let redViolet = 0xeb0f8c
        return UIColor.rgb(fromHex: redViolet)
    }
    
    class func rgb(fromHex: Int) -> UIColor {

        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
