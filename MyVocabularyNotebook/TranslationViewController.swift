//
//  TranslationViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 02..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit
import os.log

class TranslationViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var sourceTranslationView: UITextView!
    @IBOutlet weak var targetTranslationView: UITextView!
    @IBOutlet weak var saveButtonNav: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    
    var translation: Translation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        sourceTranslationView.delegate = self
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()


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
    
    //MARK: UITextFieldDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
        saveButtonNav.isEnabled = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = sourceTranslationView.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        saveButtonNav.isEnabled = !text.isEmpty
    }
    

}
