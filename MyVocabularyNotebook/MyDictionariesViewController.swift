//
//  MyDictionariesViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 17..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class MyDictionariesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myDictionariesTableView: UITableView!
    
    let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var myDictionaries: [MyDictionary] = [MyDictionary]()
    var selectedDictionary: MyDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            for url in directoryContents{
                myDictionaries.append(PersistenceHelper.loadDictionary(url: url)!)
            }
        } catch let error as NSError {
            Utils.print(error.localizedDescription)
        }
        
        myDictionariesTableView.delegate = self
        myDictionariesTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDictionaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MyDictionaryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyDictionaryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MyDictionaryTableViewCell.")
        }
        
        let myDictionary = myDictionaries[indexPath.row]
        
        cell.myDictionaryName.text = myDictionary.sourceLanguageName + " :: " + myDictionary.targetLanguageName
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedDictionary = myDictionaries[indexPath.row]
//    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "dictionarySelected":
//            guard let translationTableViewController = segue.destination as? TranslationTableViewController else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
            guard let selectedDictionaryCell = sender as? MyDictionaryTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = myDictionariesTableView.indexPath(for: selectedDictionaryCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
//            let selectedTranslation = selectedDictionary.translations[indexPath.row]
            selectedDictionary = myDictionaries[indexPath.row]
//            translationDetailViewController.translation = selectedTranslation
//            translationDetailViewController.myDictionary = selectedDictionary
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
