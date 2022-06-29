//
//  WalkthroughPageControllerViewController.swift
//  IceBreaker
//
//  Created by shy attoun on 16/07/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit

protocol WTPVCDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}
class WalkthroughPageViewController: UIPageViewController ,UIPageViewControllerDataSource,UIPageViewControllerDelegate{
    weak var WTDelegate: WTPVCDelegate?
    var pageHeadings = ["Welcome to Icebreaker App!","We got some great features for you","Help us improve buddy!"]
    
    var pageSubHeadings = ["Icebreaker App was designed to increase your chances of having a successful date!","Things aint going well for you? try these cool features to start off your date smoothly","we helped you out,now its your turn dude [or didi],write us and help us help others!"]
    
    var pageImages = ["temp_ls","date-1","idea"]
    
    var currentIndex = 0
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkThroughContentController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkThroughContentController).index
        index += 1
        
        return contentViewController(at: index)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
 
    func contentViewController (at index: Int) -> WalkThroughContentController? {
        if index < 0 || index >= pageHeadings.count{
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WTCVC") as? WalkThroughContentController {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings [index]
            pageContentViewController.subheading = pageSubHeadings [index]
            pageContentViewController.index = index
            
            return pageContentViewController
            
        }
        return nil
    }
    
    func forwardPage () {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex){
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed{
            if let contentViewController = pageViewController.viewControllers?.first as? WalkThroughContentController{
                currentIndex = contentViewController.index
                
                WTDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }

   
}
