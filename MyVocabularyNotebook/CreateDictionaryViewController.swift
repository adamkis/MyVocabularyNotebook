//
//  CreateDictionaryViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 12..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class CreateDictionaryViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var sourceLanguage: UIPickerView!
    @IBOutlet weak var targetLanguage: UIPickerView!
    @IBOutlet weak var saveButtonNavBar: UIBarButtonItem!
    
    var languageCodesAndNames = [(id: String, name: String)]()
    var selectedSourceLanguage: (id: String, name: String)!
    var selectedTargetLanguage: (id: String, name: String)!
    
    var createdDictionary: MyDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for code in NSLocale.isoLanguageCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.languageCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Language not found for code: \(code)"
            languageCodesAndNames.append((id, name))
        }
        
        languageCodesAndNames = languageCodesAndNames.sorted(){ $0.name < $1.name }
        selectedSourceLanguage = languageCodesAndNames[0]
        selectedTargetLanguage = languageCodesAndNames[0]
        
        // Select the source language what the device language is
        let deviceLanguage = Locale.preferredLanguages[0]
        var deviceLanguageRow = 0;
        for language in languageCodesAndNames {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButtonNavBar else {
            Utils.log("The save button was not pressed, cancelling")
            return
        }
        
        createdDictionary = MyDictionary(sourceLanguageCode: selectedSourceLanguage.id, targetLanguageCode: selectedTargetLanguage.id, sourceLanguageName: selectedSourceLanguage.name, targetLanguageName: selectedTargetLanguage.name, translations: nil)
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
