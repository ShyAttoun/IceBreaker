//
//  ViewController.swift
//  practing
//
//  Created by shy attoun on 03/03/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit

class WalkThroughContentController: UIViewController {
    
    
    @IBOutlet var headingLabel: UILabel! {
        didSet{
            headingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var subheadingLabel: UILabel!{
        didSet{
            subheadingLabel.numberOfLines = 0
        }
    }
    @IBOutlet var contentImageView: UIImageView!
    
    var index  = 0
    var heading  = ""
    var subheading = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        subheadingLabel.text = subheading
        contentImageView.image = UIImage(named: imageFile)
    }

  


}

