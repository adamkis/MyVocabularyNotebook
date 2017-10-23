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
    @IBOutlet weak var translationText: UITextView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backLabel: UILabel!
    
    var pageIndex: Int?
    var dummyString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translationText.text = dummyString
        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        cardView.addGestureRecognizer(tapRecognizer)
        
        backView.isHidden = true
        backView.layer.cornerRadius = 25
        backView.layer.masksToBounds = true
        backLabel.text = dummyString! + " Back"
        
    }

    @objc func handleTap() {
        Utils.print("tapped")
        perform(#selector(flip), with: nil, afterDelay: 0)
    }
    
    @objc func flip() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: cardView, duration: 1.0, options: transitionOptions, animations: {
            self.cardView.isHidden = true
        })
        
        UIView.transition(with: backView, duration: 1.0, options: transitionOptions, animations: {
            self.backView.isHidden = false
        })
    }
}

