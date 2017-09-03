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
    @IBOutlet weak var sourceTranslationView: UITextView!
    @IBOutlet weak var targetTranslationView: UITextView!
    @IBOutlet weak var saveButtonNav: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    
    var translation: Translation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        let borderWidth = CGFloat(1.0)
        let cornerRadius = CGFloat(5.0)
        
        sourceTranslationView.layer.borderColor = borderColor
        sourceTranslationView.layer.borderWidth = borderWidth
        sourceTranslationView.layer.cornerRadius = cornerRadius
        targetTranslationView.layer.borderColor = borderColor
        targetTranslationView.layer.borderWidth = borderWidth
        targetTranslationView.layer.cornerRadius = cornerRadius
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when any save button is pressed.
        let buttonNav = sender as? UIBarButtonItem;
        let button = sender as? UIButton;
        if( buttonNav == nil && button == nil ){
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let sourceTranslation = sourceTranslationView.text
        let targetTranslation = targetTranslationView.text
        
        translation = Translation(sourceTranslation: sourceTranslation, targetTranslation: targetTranslation)
        
    }
    

}
