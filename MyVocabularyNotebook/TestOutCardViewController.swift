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
    
    var parentPVC: TestOutPageViewController?
    var pageIndex: Int?
    var translation: Translation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentPVC = parent as? TestOutPageViewController
        
        NotificationCenter.default.addObserver(self, selector: #selector(TestOutCardViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TestOutCardViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        sourceTranslation.text = translation?.sourceTranslation
        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
        
        let showTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(flip))
        showButton.addGestureRecognizer(showTapRecognizer)
        let nextTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(nextCard))
        nextButton.addGestureRecognizer(nextTapRecogniser)
        
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

    @objc func nextCard() {
        parentPVC?.goToNextPage()
    }
    
    private func setGuess (guess: String?){
        let yourGuessPreText = NSLocalizedString("Your guess: ", comment: "Stands in front of the guess at test out function")
        if let myGuessInput = guess {
            myGuessText.text = yourGuessPreText + myGuessInput
        }
    }
    
    @objc func flip() {
        
        setGuess(guess: targetTranslation.text)
        parentPVC?.selectedDictionary.translations[pageIndex!].guess = targetTranslation.text!
        parentPVC?.reloadData()
        
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

