//
//  TranslationViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 02..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit
import os.log

class TranslationViewController: UIViewController {

//    @IBOutlet weak var sourceTranslationUITextView: UITextView!
//    @IBOutlet weak var targetTranslationUITextView: UITextView!
//    @IBOutlet weak var saveButtonNavBar: UIBarButtonItem!
//    @IBOutlet weak var saveButton: UIButton!
    
    
    var translation: Translation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
//        let borderWidth = CGFloat(1.0)
//        let cornerRadius = CGFloat(5.0)
        
//        sourceTranslationUITextView.layer.borderColor = borderColor
//        sourceTranslationUITextView.layer.borderWidth = borderWidth
//        sourceTranslationUITextView.layer.cornerRadius = cornerRadius
//        targetTranslationUITextView.layer.borderColor = borderColor
//        targetTranslationUITextView.layer.borderWidth = borderWidth
//        targetTranslationUITextView.layer.cornerRadius = cornerRadius
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
//        guard let button = sender as? UIBarButtonItem, button === saveButtonNavBar,
//            let button2 = sender as? UIButton, button2 === saveButton
//            else {
//                os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
//                return
//            }
//        let sourceTranslation = sourceTranslationUITextView.text
//        let targetTranslation = targetTranslationUITextView.text
//        translation = Translation(sourceTranslation: sourceTranslation, targetTranslation: targetTranslation)
    }

}
