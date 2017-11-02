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
    
    var toShow: String? = nil
    var toGuess: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentPVC = parent as? TestOutPageViewController
        
        NotificationCenter.default.addObserver(self, selector: #selector(TestOutCardViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TestOutCardViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        if translation?.selectedToAsk == .Source {
            toShow = translation?.sourceTranslation
            toGuess = translation?.targetTranslation
        }
        else{
            toShow = translation?.targetTranslation
            toGuess = translation?.sourceTranslation
        }
        
        // Front view
        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
        
        sourceTranslation.text = toShow
        
        // Back view
        backView.layer.cornerRadius = 25
        backView.layer.masksToBounds = true
        
        if(translation?.guess == nil){
            backView.isHidden = true
        }
        else{
            setGuess(guess: translation?.guess)
            cardView.isHidden = true
        }
        
        correctAnswerText.text = toGuess
        sourceLanguageLabel.text = toShow
        
        Utils.print(translation?.selectedToAsk)
        
        // Gesture Recognisers
        let showTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(flip))
        showButton.addGestureRecognizer(showTapRecognizer)
        
        // Handle last page
        Utils.print(pageIndex)
        Utils.print(parentPVC?.selectedDictionary.translations.count)
        if(pageIndex! == (parentPVC?.selectedDictionary.translations.count)!-1){
            nextButton.setTitle("Finish", for: .normal)
            let finishTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(finish))
            nextButton.addGestureRecognizer(finishTapRecogniser)
        }
        else{
            nextButton.setTitle("Next", for: .normal)
            let nextTapRecogniser = UITapGestureRecognizer(target: self, action: #selector(nextCard))
            nextButton.addGestureRecognizer(nextTapRecogniser)
        }
        
    }

    @objc func nextCard() {
        parentPVC?.goToNextPage()
    }
    
    @objc func finish() {
        let refreshAlert = UIAlertController(title: "Results", message: "Results: \(pageIndex ?? 0)", preferredStyle: UIAlertControllerStyle.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.performSegue(withIdentifier: "finishTestOut", sender: self)
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    private func setGuess (guess: String?){
        let yourGuessPreText = NSLocalizedString("Your guess: ", comment: "Stands in front of the guess at test out function")
        if let myGuessInput = guess {
            let dist = Utils.levenshteinRatio(aStr: myGuessInput.lowercased(), bStr: (toGuess)!.lowercased())
            myGuessText.text = yourGuessPreText + myGuessInput + String(dist)
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

