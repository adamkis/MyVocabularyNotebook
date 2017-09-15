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
    
    var languageCodesAndNames = [(id: String, name: String)]()
    var selectedSourceLanguage: (id: String, name: String)!
    var selectedTargetLanguage: (id: String, name: String)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        var languages: [String] = []
        
        for code in NSLocale.isoLanguageCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.languageCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Language not found for code: \(code)"
//            languages.append(id + "->" + name)
            languageCodesAndNames.append((id, name))
        }
        
        languageCodesAndNames = languageCodesAndNames.sorted(){ $0.name < $1.name }
        
        //        print(languages)
        print(languageCodesAndNames)
        
        
        // TODO ATTACH DATA SOURCE PROPERLY
        self.sourceLanguage.dataSource = self;
        self.targetLanguage.dataSource = self;
        self.sourceLanguage.delegate = self;
        self.targetLanguage.delegate = self;

    }
    
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return languageCodesAndNames.count
        return 1
    }

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return languageCodesAndNames.count
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
            print("Selected source language \(selectedSourceLanguage)")
        } 
        else if pickerView == targetLanguage {
            selectedTargetLanguage = languageCodesAndNames[row]
            print("Selected target language \(selectedTargetLanguage)")
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
