//
//  TranslationTableViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 08. 31..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit
import os.log

class TranslationTableViewController: UITableViewController {

    // MARK: Properties
    var myDictinaryGerEng: MyDictionary!
    var emptyLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        myDictinaryGerEng = MyDictionary(sourceLanguageCode: "de", targetLanguageCode: "en", sourceLanguageName: "German", targetLanguageName: "English", translations: nil)
        
        // TEST
        self.performSegue(withIdentifier: "CreateDictionary", sender:self)
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        guard let savedDictionary = loadDictionary() else {
            if (myDictinaryGerEng.translations.count < 1){
                emptyLabel = TableViewHelper.EmptyMessage(message: "You don't have any translations yet.\nTap the plus icon to make your first one", viewController: self)
            }
            return
        }
        myDictinaryGerEng = savedDictionary
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDictinaryGerEng.translations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TranslationTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TranslationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let translation = myDictinaryGerEng.translations[indexPath.row]
        
        cell.translationTextView1.text = translation.sourceTranslation
        cell.translationTextView2.text = translation.targetTranslation
        
        cell.translationTextView1.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.translationTextView2.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8);
        cell.translation1Background.layer.cornerRadius = 5;
        cell.translation2Background.layer.cornerRadius = 5;
        
        
        return cell
        
    }
    
    //MARK: Private methods
    private func saveDictionary() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(myDictinaryGerEng, toFile: myDictinaryGerEng.getArchiveUrl().path)
        if isSuccessfulSave {
            os_log("Translations successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save translations...", log: OSLog.default, type: .error)
        }
    }
    
    private func getSelectedDictionaryId() -> String {
        // TODO change
        // TEMPORARY FOR TESTING
        return "de::en"
    }
    
    private func getArchiveUrl(dictionaryId: String!) -> URL {
        //MARK: Archiving Paths
        let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        return DocumentsDirectory.appendingPathComponent(dictionaryId)
    }
    
    private func loadDictionary() -> MyDictionary?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: getArchiveUrl(dictionaryId: getSelectedDictionaryId()).path) as? MyDictionary
    }
    
    
    //MARK: Actions
    
    @IBAction func unwindToTranslationList(sender: UIStoryboardSegue) {
        
        if(emptyLabel != nil){
            self.tableView.backgroundView = nil
            emptyLabel?.removeFromSuperview()
            emptyLabel = nil
        }
        
        if let sourceViewController = sender.source as? TranslationViewController, let translation = sourceViewController.translation {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                myDictinaryGerEng.translations[selectedIndexPath.row] = translation
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                // Add new translation
                let newIndexPath = IndexPath(row: myDictinaryGerEng.translations.count, section: 0)
                myDictinaryGerEng.translations.append(translation)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // Save the meals.
            saveDictionary()
        }
        
        if let sourceViewController = sender.source as? CreateDictionaryViewController, let createdDictionary = sourceViewController.createdDictionary {
            print("Created dictionary: Source lang: \(createdDictionary.sourceLanguageName), Target Lang: \(createdDictionary.targetLanguageName), Dict object: \(createdDictionary)")
        }
        
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
            myDictinaryGerEng.translations.remove(at: indexPath.row)
            saveDictionary()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove:Translation = myDictinaryGerEng.translations[fromIndexPath.row]
        myDictinaryGerEng.translations.remove(at: fromIndexPath.row)
        myDictinaryGerEng.translations.insert(itemToMove, at: to.row)
        saveDictionary()
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "AddItem":
                os_log("Adding a new translation.", log: OSLog.default, type: .debug)
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
                let selectedMeal = myDictinaryGerEng.translations[indexPath.row]
                translationDetailViewController.translation = selectedMeal
            case "CreateDictionary":
                os_log("Creating new dictionary.", log: OSLog.default, type: .debug)
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
