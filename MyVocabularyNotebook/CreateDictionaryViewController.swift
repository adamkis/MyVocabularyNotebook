//
//  CreateDictionaryViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 12..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class CreateDictionaryViewController: UIViewController, UIPickerViewDataSource,      UIPickerViewDelegate {

    @IBOutlet weak var sourceLanguage: UIPickerView!
    @IBOutlet weak var targetLanguage: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        var languages: [String] = []
        var languageCodesAndNames = [(id: String, name: String)]()
        
        
        for code in NSLocale.isoLanguageCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.languageCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Language not found for code: \(code)"
//            languages.append(id + "->" + name)
            languageCodesAndNames.append((id, name))
        }
        
        languageCodesAndNames = languageCodesAndNames.sorted(){ $0.name < $1.name }
        
        //        print(languages)
        print(languageCodesAndNames)
        
        
        self.sourceLanguage.dataSource = self;
        self.targetLanguage.delegate = self;

    }
    
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == countryPicker {
//            return countryClasses.count
//        } else if pickerView == itemPicker {
//            return selectedItemsArray.count
//        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == countryPicker {
//            switch row {
//            case 0:
//                selectedItemsArray = usItems
//            case 1:
//                selectedItemsArray = euItems
//            case 2:
//                selectedItemsArray = jpItems
//            default:
//                selectedItemsArray = []
//            }
//            // IMPORTANT reload the data on the item picker
//            itemPicker.reloadAllComponents()
//        } else if pickerView == itemPicker {
//            // Get the current item
//            var item = selectedItemsArray[row]
//            // Assign value to a label based on which array we are using
//            if selectedItemsArray == usItems {
//                usLabel.text = item
//            } else if selectedItemsArray == euItems {
//                euLabel.text = item
//            } else if selectedItemsArray == jpItems {
//                jpLabel.text = item
//            }
//        }
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
