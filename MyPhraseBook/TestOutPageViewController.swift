//
//  TestOutPageViewController.swift
//  MyPhraseBook
//
//  Created by Adam on 2017. 10. 17..
//  Copyright © 2017. Adam. All rights reserved.
//
// inspiration: https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions
//

import UIKit

class TestOutPageViewController: UIPageViewController {
    
    var selectedPhraseBook: PhraseBook!
    
    var pageControl: UIPageControl? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        for view in view.subviews {
            if view is UIPageControl{
                pageControl = view as? UIPageControl
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let savedPhraseBookId = PersistenceHelper.loadSelectedPhraseBookId() else{
            self.performSegue(withIdentifier: "CreatePhraseBook", sender:self)
            return
        }
        selectedPhraseBook = PersistenceHelper.loadPhraseBook(phraseBookId: savedPhraseBookId)
        selectedPhraseBook.translations = selectedPhraseBook.translations.shuffled.choose(10)
        selectedPhraseBook.randomizeForTestOut()
        
        reloadData()
        setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)
        
    }
    
    internal func reloadData(){
        dataSource = nil;
        dataSource = self;
    }
    
}

// MARK: Page view controller paging

extension TestOutPageViewController {

    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) as? TestOutCardViewController else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
        pageControl?.currentPage = nextViewController.pageIndex!
        
    }
    
    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) as? TestOutCardViewController else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
        pageControl?.currentPage = previousViewController.pageIndex!
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
        
        if let viewController = viewController as? TestOutCardViewController, let pageIndex = viewController.pageIndex, pageIndex < selectedPhraseBook.translations.count - 1 {
            return viewControllerAtIndex(pageIndex + 1)
        }

        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return selectedPhraseBook.translations.count
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
            cardViewController.translation = selectedPhraseBook.translations[index]

            return cardViewController
        }
        
        return nil
    }
}


protocol ViewControllerProvider {
    var initialViewController: UIViewController { get }
    func viewControllerAtIndex(_ index: Int) -> UIViewController?
}


