//
//  TestOutCardViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 10. 17..
//  Copyright © 2017. Adam. All rights reserved.
// inspiration: https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions
//

import UIKit

private let revealSequeId = "revealSegue"

class TestOutCardViewController: UIViewController {
    
//    @IBOutlet fileprivate weak var cardView: UIView!
//    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int?
    var dummyString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = dummyString
        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        cardView.addGestureRecognizer(tapRecognizer)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == revealSequeId, let destinationViewController = segue.destination as? RevealViewController {
//            destinationViewController.petCard = petCard
//        }
//    }
//
//    func handleTap() {
//        performSegue(withIdentifier: revealSequeId, sender: nil)
//    }
}

