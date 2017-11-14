//
//  PhraseBookListViewController.swift
//  MyPhraseBook
//
//  Created by Adam on 2017. 09. 17..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class PhraseBookListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    @IBOutlet weak var phraseBookListTableView: UITableView!
    var phraseBookList: [PhraseBook] = [PhraseBook]()
    var selectedPhraseBook: PhraseBook!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phraseBookList = PersistenceHelper.getPhraseBookList()
        phraseBookListTableView.delegate = self
        phraseBookListTableView.dataSource = self
    }

    // MARK: - Table view Delegate Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phraseBookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PhraseBookTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PhraseBookTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PhraseBookTableViewCell.")
        }
        
        let myDictionary = phraseBookList[indexPath.row]
        
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
            guard let selectedDictionaryCell = sender as? PhraseBookTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = phraseBookListTableView.indexPath(for: selectedDictionaryCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            selectedPhraseBook = phraseBookList[indexPath.row]
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
