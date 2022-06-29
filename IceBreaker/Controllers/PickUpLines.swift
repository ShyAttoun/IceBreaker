//  PickUpLines.swift
//  IceBreaker
//
//  Created by shy attoun on 30/04/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import Lottie


struct PickUpLines: Decodable {
    let id: Int
    let setup: String
}

class PickUpLinesViewController: UIViewController {
    
    @IBOutlet weak var pickupBtn: UIButton!
    private var pul = [PickUpLines]()
    @IBOutlet weak var apimage: UIImageView!
    
    
    @IBOutlet weak var chatbox: UIView!
    @IBOutlet private var lotAnimateScreen: AnimationView!
    @IBOutlet var PULViewController: UIView!
    @IBOutlet weak var blurScreen: UIVisualEffectView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var randonBtn: UIButton!
    @IBOutlet weak var PULabel: UITextView!
    
    var effect: UIVisualEffect!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.PULViewController.backgroundColor = .lightGray
        
        
        downloadJson()
        blurEffect ()
        startAnimation()
        viewsDesign()
        imageSlideIn()
    }
    
    
    @IBAction func generateRandPUL(_ sender: Any) {
        showRandPUL ()
         viewAnimation()
        
    }

    func showRandPUL (){
        
        let randomPUL = pul.randomElement()
        PULabel.text = randomPUL?.setup
    
}
  
    func downloadJson () {

        print("started")
        let url = "https://icebreakerappinc.herokuapp.com/pickuplines"
        
        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}
            
            do {
                let PULurl = try JSONDecoder().decode([PickUpLines].self, from: data)
                
                DispatchQueue.main.async {
                    self.PULViewController.reloadInputViews()
                    self.pul = PULurl
                    print("finished")
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
    
    fileprivate func viewsDesign() {
        pickupBtn.layer.cornerRadius = 30
        apimage.layer.shadowColor = UIColor.black.cgColor
        apimage.layer.shadowOffset = CGSize (width: 2 , height: 3)
        apimage.layer.shadowRadius = 4
        apimage.layer.shadowOpacity = 0.5
        
      
    }
    
    func imageSlideIn () {
        view.addSubview(apimage)
        view.addSubview(arrow)
        view.addSubview(chatbox)
        
        arrow.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0, y: -400)
        
        chatbox.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0, y: -400)
        
        apimage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: -500, y: -20)
        
        UIView.animate(withDuration: 1, delay: 3,usingSpringWithDamping: 20, initialSpringVelocity: 0.5, options:[], animations: {
            self.apimage.transform = CGAffineTransform.identity
            self.arrow.transform = CGAffineTransform.identity
            self.chatbox.transform = CGAffineTransform.identity
            self.PULabel.text = "Check out our Pickup Lines Feature by clicking on the Action Button!"
            
        })
        
        UIView.animate(withDuration: 2, delay: 5, animations: { }) {(isComplete) in
            
        }
    }
    
    fileprivate func viewAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.arrow.transform = CGAffineTransform(translationX: 0, y: -30)
            
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.arrow.alpha = 0
                self.arrow.transform = self.arrow.transform.translatedBy(x: 0, y: -350)
                
                
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewAnimation()
    }
    
    func  blurEffect () {
        effect = blurScreen.effect
        
    }

  
}

