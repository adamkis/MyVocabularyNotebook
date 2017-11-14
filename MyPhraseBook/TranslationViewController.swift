//
//  TranslationViewController.swift
//  MyPhraseBook
//
//  Created by Adam on 2017. 09. 02..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var sourceTranslationView: UITextView!
    @IBOutlet weak var targetTranslationView: UITextView!
    @IBOutlet weak var saveButtonNav: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var sourceLanguageName: UILabel!
    @IBOutlet weak var targetLanguageName: UILabel!
    
    var translation: Translation?
    var myDictionary: MyDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        sourceTranslationView.delegate = self
        
        // Set up views if editing an existing translation.
        if let translation = translation {
            sourceTranslationView.text   = translation.sourceTranslation
            targetTranslationView.text = translation.targetTranslation
        }
        else{
            self.title = "New Phrase"
        }
        
        sourceTranslationView.becomeFirstResponder()
        
        let borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        let borderWidth = CGFloat(1.0)
        let cornerRadius = CGFloat(5.0)
        
        sourceTranslationView.layer.borderColor = borderColor
        sourceTranslationView.layer.borderWidth = borderWidth
        sourceTranslationView.layer.cornerRadius = cornerRadius
        targetTranslationView.layer.borderColor = borderColor
        targetTranslationView.layer.borderWidth = borderWidth
        targetTranslationView.layer.cornerRadius = cornerRadius
        
        sourceLanguageName.text = myDictionary?.sourceLanguageName
        targetLanguageName.text = myDictionary?.targetLanguageName
        
    }

    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddTranslationMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTranslationMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The TranslationViewController is not inside a navigation controller.")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        let buttonNav = sender as? UIBarButtonItem;
        let button = sender as? UIButton;
        if( buttonNav == nil && button == nil ){
            Utils.log("The save button was not pressed, cancelling")
            return false
        }
        let sourceTranslation: String = sourceTranslationView.text
        let targetTranslation: String = targetTranslationView.text
        if( sourceTranslation.count < 1 || targetTranslation.count < 1 ){
            showEmptyAlert()
            return false
        }
        translation = Translation(sourceTranslation: sourceTranslation, targetTranslation: targetTranslation)
        return true
    }
    
    //MARK: Helper methods
    
    func showEmptyAlert(){
        let refreshAlert = UIAlertController(title: "Empty field", message: "Please fill up both translation fields", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
        present(refreshAlert, animated: true, completion: nil)
    }

}
