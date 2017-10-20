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
    var secondView: UIView!
    
    var pageIndex: Int?
    var dummyString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = dummyString
        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        cardView.addGestureRecognizer(tapRecognizer)
        
//        firstView = UIView(frame: CGRect(x: 32, y: 32, width: 128, height: 128))
        secondView = UIView(frame: CGRect(x: 32, y: 32, width: 128, height: 128))
        
//        firstView.backgroundColor = UIColor.red
        secondView.backgroundColor = UIColor.blue
        
        secondView.isHidden = true
        
//        view.addSubview(firstView)
        view.addSubview(secondView)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == revealSequeId, let destinationViewController = segue.destination as? RevealViewController {
//            destinationViewController.petCard = petCard
//        }
//    }
//
    @objc func handleTap() {
        Utils.print("tapped")
        perform(#selector(flip), with: nil, afterDelay: 2)
    }
    
    @objc func flip() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: cardView, duration: 1.0, options: transitionOptions, animations: {
            self.cardView.isHidden = true
        })
        
        UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
            self.secondView.isHidden = false
        })
    }
}

