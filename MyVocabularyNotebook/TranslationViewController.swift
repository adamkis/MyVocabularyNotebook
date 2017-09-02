//
//  TranslationViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 02..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class TranslationViewController: UIViewController {

    @IBOutlet weak var sourceTranslation: UITextView!
    @IBOutlet weak var targetTranslation: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sourceTranslation.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor;
        sourceTranslation.layer.borderWidth = 1.0;
        sourceTranslation.layer.cornerRadius = 5.0;
        targetTranslation.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor;
        targetTranslation.layer.borderWidth = 1.0;
        targetTranslation.layer.cornerRadius = 5.0;
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
