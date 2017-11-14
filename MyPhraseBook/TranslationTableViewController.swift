//
//  TranslationTableViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 08. 31..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class TranslationTableViewController: UITableViewController, UISearchResultsUpdating {

    // MARK: Properties
    var selectedDictionary: MyDictionary!
    var filteredDictionary: MyDictionary!
    var emptyLabel: UILabel?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Testing printing things
        UserDefaults.standard.removeObject(forKey: "DICTIONARY_KEY")
        PersistenceHelper.printAllUserDefaults()
        PersistenceHelper.printAllFilesInDirectory()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        guard let savedDictionaryId = PersistenceHelper.loadSelectedDictionaryId() else{
            self.performSegue(withIdentifier: "CreateDictionary", sender:self)
            return
        }
        selectedDictionary = PersistenceHelper.loadDictionary(dictionaryId: savedDictionaryId)
        if (selectedDictionary.translations.count < 1){
            showEmptyMessage()
        }
        
        self.title = selectedDictionary.getDisplayName()
        
        // Setting up search
        filteredDictionary = MyDictionary(selectedDictionary)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.customTurquoiseDark
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    // MARK: - Search
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredDictionary.translations = selectedDictionary.translations.filter({( translation : Translation) -> Bool in
            let textToCompare = translation.sourceTranslation.lowercased() + translation.targetTranslation.lowercased()
            return textToCompare.contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    // MARK: - Table view Delegate Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            if filteredDictionary != nil {
                return filteredDictionary.translations.count
            }
            else{
                return 0
            }
        }
        if( selectedDictionary != nil ){
            return selectedDictionary.translations.count
        }
        else{
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TranslationTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TranslationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TranslationTableViewCell.")
        }
        
        let translation: Translation
        if isFiltering() {
            translation = filteredDictionary.translations[indexPath.row]
        } else {
            translation = selectedDictionary.translations[indexPath.row]
        }
//        let translation = selectedDictionary.translations[indexPath.row]
        
        cell.translationLabel1.text = translation.sourceTranslation
        cell.translationLabel2.text = translation.targetTranslation
        
        cell.translation1Background.layer.cornerRadius = 5;
        cell.translation2Background.layer.cornerRadius = 5;
        
        
        return cell
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            selectedDictionary.translations.remove(at: indexPath.row)
            PersistenceHelper.saveDictionary(selectedDictionary: selectedDictionary)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove:Translation = selectedDictionary.translations[fromIndexPath.row]
        selectedDictionary.translations.remove(at: fromIndexPath.row)
        selectedDictionary.translations.insert(itemToMove, at: to.row)
        PersistenceHelper.saveDictionary(selectedDictionary: selectedDictionary)
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    
    //MARK: Private methods

    private func showEmptyMessage(){
        let emptyText = NSLocalizedString("You don't have any translations yet.\nTap the plus icon to make your first one", comment: "Show this when dictionary is empty")
        emptyLabel = TableViewHelper.EmptyMessage(message: emptyText, viewController: self)
    }
    
    
    func showTestOutNotPossibleAlert(){
        let testOutNotPossibleAlert = UIAlertController(title: NSLocalizedString("You don't have any translations yet.\nTap the plus icon to make your first one", comment: "Show this when dictionary is empty"), message: nil, preferredStyle: UIAlertControllerStyle.alert)
        testOutNotPossibleAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
        present(testOutNotPossibleAlert, animated: true, completion: nil)
    }

    func showSelectedDictionary(myDictionary: MyDictionary){
        PersistenceHelper.saveSelectedDictionaryId(myDictionary: myDictionary)
        selectedDictionary = myDictionary
        PersistenceHelper.saveDictionary(selectedDictionary: selectedDictionary)
        self.title = selectedDictionary.getDisplayName()
        self.tableView.reloadData()
        if (selectedDictionary.translations.count < 1){
            showEmptyMessage()
        }
    }
    
    func shareDictionary(myDictionary: MyDictionary){
        // get the extraction of the dictionary
        let dictionaryExtractString = myDictionary.getShareString()
        // set up activity view controller
        let textToShare = [ dictionaryExtractString ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        // so that iPads won't crash
        activityViewController.popoverPresentationController?.sourceView = self.view
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    //MARK: Navigation
    @IBAction func sharePressed(_ sender: Any) {
        Utils.print(selectedDictionary.getShareString())
        shareDictionary(myDictionary: selectedDictionary)
    }
    
    @IBAction func unwindToTranslationList(sender: UIStoryboardSegue) {
        
        if(emptyLabel != nil){
            self.tableView.backgroundView = nil
            emptyLabel?.removeFromSuperview()
            emptyLabel = nil
        }
        
        if let sourceViewController = sender.source as? TranslationViewController, let translation = sourceViewController.translation {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing translation.
                selectedDictionary.translations[selectedIndexPath.row] = translation
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                // Add new translation
                let newIndexPath = IndexPath(row: selectedDictionary.translations.count, section: 0)
                selectedDictionary.translations.append(translation)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // Save the dictionary.
            PersistenceHelper.saveDictionary(selectedDictionary: selectedDictionary)
        }
        
        if let sourceViewController = sender.source as? CreateDictionaryViewController, let createdDictionary = sourceViewController.createdDictionary {
            // Dictionary created
            showSelectedDictionary(myDictionary: createdDictionary)
        }
        if let sourceViewController = sender.source as? MyDictionariesViewController, let unwindedSelectedDictionary = sourceViewController.selectedDictionary {
            // Dictionary created
            showSelectedDictionary(myDictionary: unwindedSelectedDictionary)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "AddItem":
                let navVC = segue.destination as! UINavigationController
                let addTranslationViewController = navVC.viewControllers.first as! TranslationViewController
                addTranslationViewController.myDictionary = selectedDictionary
                Utils.log("Adding a new translation.")
            case "ShowDetail":
                guard let translationDetailViewController = segue.destination as? TranslationViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            
                guard let selectedTranslationCell = sender as? TranslationTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
            
                guard let indexPath = tableView.indexPath(for: selectedTranslationCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                let selectedTranslation: Translation
                if isFiltering() {
                    selectedTranslation = filteredDictionary.translations[indexPath.row]
                } else {
                    selectedTranslation = selectedDictionary.translations[indexPath.row]
                }
                translationDetailViewController.translation = selectedTranslation
                translationDetailViewController.myDictionary = selectedDictionary
            case "CreateDictionary":
                Utils.log("Creating new dictionary.")
            case "MyDictionaries":
                Utils.log("Showing my dictionaries in a list.")
            case "ShowTestOut":
                if selectedDictionary.translations.count < 1{
                    showTestOutNotPossibleAlert()
                    return
                }
                Utils.log("Showing test out function")
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
}