//
//  Funny Facts.swift
//  IceBreaker
//
//  Created by shy attoun on 30/04/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import Lottie

struct FunnyFacts: Decodable {
    let id: Int
    let setup: String
}

class FunnyFactsViewController: UIViewController {
    
    private var ff = [FunnyFacts] ()
    
    @IBOutlet var lotAnimateScreen: AnimationView!
   
    @IBOutlet weak var chatbox: UIView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var blurScreen: UIVisualEffectView!
    @IBOutlet var FFviewController: UIView!
    @IBOutlet weak var smartguyImage: UIImageView!
    @IBOutlet weak var randomBtn: UIButton!
    
    @IBOutlet weak var smartGuyConst: NSLayoutConstraint!
    @IBOutlet weak var FFText: UITextView!

    
    var effect: UIVisualEffect!

    override func viewDidLoad() {
        super.viewDidLoad()
        
     viewsDesign ()
        
        blurEffect ()
        startAnimation()
         downloadJson ()
        imageSlideIn()
    }
    
    @IBAction func nextFact(_ sender: UIButton) {
        
        showRandFact ()
        viewsAnimation()
    }
    
    func showRandFact () {
        
        let randomFF  = ff.randomElement()
        FFText.text = randomFF?.setup
 
    }
    
    func downloadJson () {
        
        let url = "https://icebreakerappinc.herokuapp.com/funnyfacts"
        
        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}
            
            do {
                let FFurl = try JSONDecoder().decode([FunnyFacts].self, from: data)
                
                DispatchQueue.main.async {
                    self.FFviewController.reloadInputViews()
                    self.ff = FFurl
                }
            }catch let jsonErr {
                print("Error serializing json:" , jsonErr)
            }
            }.resume()
    }
    
    func startAnimation (){
        
        view.addSubview(lotAnimateScreen)
        lotAnimateScreen.layer.cornerRadius = 50
        lotAnimateScreen.center = view.center
        lotAnimateScreen.animation = Animation.named("77-im-thirsty")
        lotAnimateScreen.loopMode = .loop
        lotAnimateScreen.play()
        
        lotAnimateScreen.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: -500, y: 0)
        
        UIView.animate(withDuration: 1, animations: {
            self.lotAnimateScreen.transform = CGAffineTransform.identity
            self.blurScreen.effect = self.effect
        })
        
        UIView.animate(withDuration: 3, animations: {
            self.blurScreen.effect = nil
        }) {(isComplete) in
            
            self.blurScreen.removeFromSuperview()
            self.lotAnimateScreen.removeFromSuperview()
        }
    }
    
    func imageSlideIn () {
        view.addSubview(smartguyImage)
        view.addSubview(arrow)
        view.addSubview(chatbox)
        
        arrow.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0, y: -400)
        
        chatbox.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0, y: -400)
        
        smartguyImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: -500, y: -20)
        
        UIView.animate(withDuration: 1, delay: 3,usingSpringWithDamping: 20, initialSpringVelocity: 0.5, options:[], animations: {
            self.smartguyImage.transform = CGAffineTransform.identity
            self.arrow.transform = CGAffineTransform.identity
            self.chatbox.transform = CGAffineTransform.identity
           
        })
        
        UIView.animate(withDuration: 2, delay: 5, animations: { }) {(isComplete) in
            
        }
    }
    
    func  blurEffect () {
        effect = blurScreen.effect
        
    }
    
   func viewsDesign () {
    randomBtn.layer.cornerRadius = 25
    
    randomBtn.layer.shadowColor = UIColor.black.cgColor
    randomBtn.layer.shadowOffset = CGSize (width: 2, height: 0)
    randomBtn.layer.shadowRadius = 0.5
    randomBtn.layer.shadowOpacity = 0.5
    
    
    smartguyImage.layer.shadowColor = UIColor.black.cgColor
    smartguyImage.layer.shadowOffset = CGSize (width: 2 , height: 3)
    smartguyImage.layer.shadowRadius = 4
    smartguyImage.layer.shadowOpacity = 0.5
    }
    
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewsAnimation()
    }
   
    fileprivate func viewsAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.smartguyImage.transform = CGAffineTransform(translationX: -30, y: 0)
            self.arrow.transform = CGAffineTransform(translationX: 0, y: -30)
            self.chatbox.transform = CGAffineTransform(translationX: 0, y: -20)
        }) { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.smartguyImage.alpha = 0
                self.arrow.alpha = 0
                self.chatbox.alpha = 0
                
                self.smartguyImage.transform = self.smartguyImage.transform.translatedBy(x: 0, y: -350)
                
                self.arrow.transform = self.arrow.transform.translatedBy(x: 0, y: -350)
                
                self.chatbox.transform = self.chatbox.transform.translatedBy(x: 0, y: -350)
            })
        }
    }
}


