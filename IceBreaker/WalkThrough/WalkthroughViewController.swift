//
//  WalkthroughViewController.swift
//  IceBreaker
//
//  Created by shy attoun on 16/07/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController,WTPVCDelegate {
    
    var wtpvc: WalkthroughPageViewController?

    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var skipButton: UIButton!
    
    @IBAction func skipBtnTapped(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
         dismiss(animated: true, completion: nil)
    }
   
    @IBAction func nextBtnTapped(_ sender: Any) {
    
        if let index  = wtpvc?.currentIndex {
            switch index {
            case 0...1:
                wtpvc?.forwardPage()
                
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
                
            default: break
            }
        }
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

 
    func updateUI (){
        if let index = wtpvc?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("Next", for: .normal)
                skipButton.isHidden = false
                
            case 2:
                nextButton.setTitle("Get Started", for: .normal)
                skipButton.isHidden = true
                
            default:break
            }
            pageControl.currentPage = index
        }
    }
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            wtpvc =  pageViewController
            wtpvc?.WTDelegate = self
        }
    }
}
