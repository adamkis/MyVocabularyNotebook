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
    @IBOutlet weak var sourceTranslation: UILabel!
    @IBOutlet weak var targetTranslation: UITextField!
    @IBOutlet weak var showButton: UIButton!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    @IBOutlet weak var correctAnswerText: UILabel!
    @IBOutlet weak var myGuessText: UILabel!
    @IBOutlet weak var isCorrectImage: UIImageView!
    @IBOutlet weak var itWasRightButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var pageIndex: Int?
    var translation: Translation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TestOutCardViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TestOutCardViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        sourceTranslation.text = translation?.sourceTranslation
        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        showButton.addGestureRecognizer(tapRecognizer)
        
        backView.layer.cornerRadius = 25
        backView.layer.masksToBounds = true
        
        if(translation?.guess == nil){
            backView.isHidden = true
        }
        else{
            setGuess(guess: translation?.guess)
            cardView.isHidden = true
        }
        
        correctAnswerText.text = translation?.targetTranslation
        sourceLanguageLabel.text = translation?.sourceTranslation
        
        Utils.print("ViewDidLoad" + (translation?.sourceTranslation)!)
    }

    @objc func handleTap() {
        Utils.print("tapped")
        perform(#selector(flip), with: nil, afterDelay: 0)
    }
    
    private func setGuess (guess: String?){
        let yourGuessPreText = NSLocalizedString("Your guess: ", comment: "Stands in front of the guess at test out function")
        if let myGuessInput = guess {
            myGuessText.text = yourGuessPreText + myGuessInput
        }
    }
    
    @objc func flip() {
        
        if let parentPVC = parent as? TestOutPageViewController{
            setGuess(guess: targetTranslation.text)
            parentPVC.selectedDictionary.translations[pageIndex!].guess = targetTranslation.text!
            parentPVC.reloadData()
        }
        
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: cardView, duration: 1.0, options: transitionOptions, animations: {
            self.cardView.isHidden = true
        })
        
        UIView.transition(with: backView, duration: 1.0, options: transitionOptions, animations: {
            self.backView.isHidden = false
        })
    }
    
    // MARK: handle keyboard
    
    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
                self.view.frame.origin.y -= 60
            }
//        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
//                self.view.frame.origin.y += keyboardSize.height
                self.view.frame.origin.y += 60
            }
//        }
    }
    
    @IBAction func onBackgroundTouchUpInside(_ sender: Any) {
        view.endEditing(true)
    }
    
}

