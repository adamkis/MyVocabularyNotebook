//
//  MyDictionariesViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 17..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class MyDictionariesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
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

    // MARK: - Table view Delegate Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDictionaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MyDictionaryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyDictionaryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MyDictionaryTableViewCell.")
        }
        
        let myDictionary = myDictionaries[indexPath.row]
        
        cell.myDictionaryName.text = myDictionary.getDisplayName()
        
        return cell
        
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "CreateDictionary":
            print("Creating dictionary from Dictionaries list")
        case "dictionarySelected":
            guard let selectedDictionaryCell = sender as? MyDictionaryTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = myDictionariesTableView.indexPath(for: selectedDictionaryCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            selectedDictionary = myDictionaries[indexPath.row]
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
