//
//  MyDictionariesViewController.swift
//  MyPhraseBook
//
//  Created by Adam on 2017. 09. 17..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class MyDictionariesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    @IBOutlet weak var myDictionariesTableView: UITableView!
    var myDictionaries: [PhraseBook] = [PhraseBook]()
    var selectedDictionary: PhraseBook!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myDictionaries = PersistenceHelper.getAllPhraseBooks()
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
