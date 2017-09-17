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
    
    var tempArray: [String] = ["en:de","en:fr"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myDictionariesTableView.delegate = self
        myDictionariesTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MyDictionaryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyDictionaryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MyDictionaryTableViewCell.")
        }
        
        let name = tempArray[indexPath.row]
        
        cell.myDictionaryName.text = name
        
        return cell
        
    }
    

    
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0 // your number of cell here
//    }
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        // your cell coding
//        return UITableViewCell()
//    }
//
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        // cell selected code here
//    }

}
