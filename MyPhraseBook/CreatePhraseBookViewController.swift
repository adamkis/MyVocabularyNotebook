//
//  CreatePhraseBookViewController.swift
//  MyPhraseBook
//
//  Created by Adam on 2017. 09. 12..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class CreatePhraseBookViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var sourceLanguage: UIPickerView!
    @IBOutlet weak var targetLanguage: UIPickerView!
    @IBOutlet weak var saveButtonNavBar: UIBarButtonItem!
    @IBOutlet weak var cancelButtonNavBar: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    @IBOutlet weak var targetLanguageLabel: UILabel!
    
    var languageCodesAndNames = [(id: String, name: String)]()
    var selectedSourceLanguage: (id: String, name: String)!
    var selectedTargetLanguage: (id: String, name: String)!
    
    var createdPhraseBook: PhraseBook!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.textColor = UIColor.customTurquoise
        sourceLanguageLabel.textColor = UIColor.customTurquoise
        targetLanguageLabel.textColor = UIColor.customTurquoise
        
        // Getting the device language
        var deviceLanguage: String = Locale.preferredLanguages[0]
        Utils.print("Device lang.:" + deviceLanguage)
        
        for code in NSLocale.isoLanguageCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.languageCode.rawValue: code])
            let name = NSLocale(localeIdentifier: deviceLanguage).displayName(forKey: NSLocale.Key.identifier, value: id) ?? nil
            if( name != nil ){
                languageCodesAndNames.append((id, name!))
            }
        }
        
        languageCodesAndNames = languageCodesAndNames.sorted(){ $0.name < $1.name }
        selectedSourceLanguage = languageCodesAndNames[0]
        selectedTargetLanguage = languageCodesAndNames[0]
        
        // Select the source language what the device language is
        if( deviceLanguage.lowercased().range(of:"-") != nil  ){
            let separated = deviceLanguage.components(separatedBy: "-")
            deviceLanguage = separated.first!
        }
        var deviceLanguageRow = 0;
        for language in languageCodesAndNames {
            Utils.print(deviceLanguage + " " + language.id)
            if language.id == deviceLanguage {
                break
            }
            deviceLanguageRow=deviceLanguageRow+1
        }
        
        self.sourceLanguage.dataSource = self;
        self.targetLanguage.dataSource = self;
        self.sourceLanguage.delegate = self;
        self.targetLanguage.delegate = self;
        
        sourceLanguage.selectRow(deviceLanguageRow, inComponent: 0, animated: false)
        selectedSourceLanguage = languageCodesAndNames[deviceLanguageRow]
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue( withIdentifier: identifier, sender: sender)

        if let button = sender as? UIBarButtonItem,  button === cancelButtonNavBar {
            Utils.log("Cancel button pressed")
            return true
        }

        let phraseBookList = PersistenceHelper.getPhraseBookList()
        for phraseBook in phraseBookList{
            if( phraseBook.sourceLanguageCode == selectedSourceLanguage.id && phraseBook.targetLanguageCode == selectedTargetLanguage.id ){
                showPhraseBookAlreadyExistsAlert()
                return false
            }
        }

        createdPhraseBook = PhraseBook(sourceLanguageCode: selectedSourceLanguage.id, targetLanguageCode: selectedTargetLanguage.id, sourceLanguageName: selectedSourceLanguage.name, targetLanguageName: selectedTargetLanguage.name, translations: nil)
        return true
    }
    
    func showPhraseBookAlreadyExistsAlert(){
        let phraseBookAlreadyExistsAlert = UIAlertController(title: NSLocalizedString("PhraseBook already exists", comment: "Show this when the user wants to create a PhraseBook when it already exists - otherwise it overwrites the old PhraseBook"), message: nil, preferredStyle: UIAlertControllerStyle.alert)
        phraseBookAlreadyExistsAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
        present(phraseBookAlreadyExistsAlert, animated: true, completion: nil)
    }

    
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageCodesAndNames.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageCodesAndNames[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sourceLanguage {
            selectedSourceLanguage = languageCodesAndNames[row]
            Utils.print("Selected source language \(selectedSourceLanguage)")
        } 
        else if pickerView == targetLanguage {
            selectedTargetLanguage = languageCodesAndNames[row]
            Utils.print("Selected target language \(selectedTargetLanguage)")
        }
    }
    

}
