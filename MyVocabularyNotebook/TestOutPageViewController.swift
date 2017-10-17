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
    
    let dummyData: [String] = ["Elso", "Masodik", "HArmadik"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)
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
        
        if let viewController = viewController as? TestOutCardViewController, let pageIndex = viewController.pageIndex, pageIndex < dummyData.count - 1 {
            return viewControllerAtIndex(pageIndex + 1)
        }

        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dummyData.count
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
            cardViewController.dummyString = dummyData[index]

            return cardViewController
        }
        
        return nil
    }
}


protocol ViewControllerProvider {
    var initialViewController: UIViewController { get }
    func viewControllerAtIndex(_ index: Int) -> UIViewController?
}


