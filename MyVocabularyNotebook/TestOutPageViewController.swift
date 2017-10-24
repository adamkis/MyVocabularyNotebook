//
//  TestOutPageViewController.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 10. 17..
//  Copyright © 2017. Adam. All rights reserved.
//
// inspiration: https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions
//

import UIKit

class TestOutPageViewController: UIPageViewController {
    
    var selectedDictionary: MyDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let savedDictionaryId = PersistenceHelper.loadSelectedDictionaryId() else{
            self.performSegue(withIdentifier: "CreateDictionary", sender:self)
            return
        }
        selectedDictionary = PersistenceHelper.loadDictionary(dictionaryId: savedDictionaryId)
        selectedDictionary.translations = selectedDictionary.translations.shuffled
        
        dataSource = self
        setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)
        
        
        // Playing with random picking
        let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let shuffledAlphabet = alphabet.shuffled
        Utils.print(shuffledAlphabet)
        let letter = alphabet.chooseOne
        Utils.print(letter)
        var numbers = Array(0...9)
        let shuffledNumbers = numbers.shuffled
        Utils.print(shuffledNumbers)                              // [8, 9, 3, 6, 0, 1, 4, 2, 5, 7]
        Utils.print(numbers)            // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        numbers.shuffle() // mutate it  [6, 0, 2, 3, 9, 1, 5, 7, 4, 8]
        Utils.print(numbers)            // [6, 0, 2, 3, 9, 1, 5, 7, 4, 8]
        let pick3numbers = numbers.choose(3)  // [8, 9, 2]
        Utils.print(pick3numbers)
        
    }
}

// MARK: Page view controller data source

extension TestOutPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? TestOutCardViewController, let pageIndex = viewController.pageIndex, pageIndex > 0 {
            return viewControllerAtIndex(pageIndex - 1)
        }

        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? TestOutCardViewController, let pageIndex = viewController.pageIndex, pageIndex < selectedDictionary.translations.count - 1 {
            return viewControllerAtIndex(pageIndex + 1)
        }

        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return selectedDictionary.translations.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

// MARK: View controller provider

extension TestOutPageViewController: ViewControllerProvider {
    
    var initialViewController: UIViewController {
        return viewControllerAtIndex(0)!
    }
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        
        if let cardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestOutCardViewController") as? TestOutCardViewController {

            cardViewController.pageIndex = index
            cardViewController.translation = selectedDictionary.translations[index]

            return cardViewController
        }
        
        return nil
    }
}


protocol ViewControllerProvider {
    var initialViewController: UIViewController { get }
    func viewControllerAtIndex(_ index: Int) -> UIViewController?
}


