//
//  Associastion.swift
//  IceBreaker
//
//  Created by shy attoun on 29/05/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import Lottie


struct Associations: Decodable {
    let id: Int
    let association: String
}

class AssociationsViewController: UIViewController {
    private var asc = [Associations]()
    
    @IBOutlet var lotAnimationScreen: AnimationView!
    @IBOutlet weak var blurScreen: UIVisualEffectView!
    @IBOutlet var ASCViewcontroller: UIView!
    @IBOutlet weak var ascTV: UITextView!
    @IBOutlet weak var chatbox: UIView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var confused: UIImageView!
    @IBOutlet weak var randomBtn: UIButton!
    @IBOutlet weak var ASCLabel: UITextView!
    var effect: UIVisualEffect!

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ASCViewcontroller.backgroundColor = .lightGray
        viewsDesign()
        blurEffect ()
        startAnimation()
       downloadAscJson ()
        imageSlideIn()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        downloadAscJson ()
    }
    
    @IBAction func GenerateRandAssociationBtn(_ sender: Any ) {
        
        showRandASC ()
        viewsAnimation()
    }
    
    func showRandASC () {
        let randomASC = asc.randomElement()
        ascTV.text = randomASC?.association
        
    }
    
    
    func downloadAscJson () {
        let url = "https://icebreakerappinc.herokuapp.com/associations"
        
        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}
            
            do {
                let ascUrl = try JSONDecoder().decode([Associations].self, from: data)
                
                DispatchQueue.main.async {
                    self.ASCViewcontroller.reloadInputViews()
                    self.asc = ascUrl
                }
            }catch let jsonErr {
                print("Error serializing json:" , jsonErr)
            }
            }.resume()
    }
    func startAnimation (){
        
        view.addSubview(lotAnimationScreen)
        lotAnimationScreen.layer.cornerRadius = 50
        lotAnimationScreen.center = view.center
        lotAnimationScreen.animation = Animation.named("77-im-thirsty")
        lotAnimationScreen.loopMode = .loop
        lotAnimationScreen.play()
        
        lotAnimationScreen.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: -500, y: 0)
        
        UIView.animate(withDuration: 1, animations: {
            self.lotAnimationScreen.transform = CGAffineTransform.identity
            self.blurScreen.effect = self.effect
        })
        
        UIView.animate(withDuration: 3, animations: {
            self.blurScreen.effect = nil
        }) {(isComplete) in
            
            self.blurScreen.removeFromSuperview()
            self.lotAnimationScreen.removeFromSuperview()
        }
    }
    
    fileprivate func viewsDesign() {
        randomBtn.layer.cornerRadius = 25
        confused.layer.shadowColor = UIColor.black.cgColor
        confused.layer.shadowOffset = CGSize (width: 2 , height: 3)
        confused.layer.shadowRadius = 4
        confused.layer.shadowOpacity = 0.5
        
    }
    
    func imageSlideIn () {
        view.addSubview(confused)
        view.addSubview(arrow)
        view.addSubview(chatbox)
        
        arrow.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0, y: -400)
        
        chatbox.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0, y: -400)
        
        confused.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: -500, y: -20)
        
        UIView.animate(withDuration: 1, delay: 3,usingSpringWithDamping: 20, initialSpringVelocity: 0.5, options:[], animations: {
            self.confused.transform = CGAffineTransform.identity
            self.arrow.transform = CGAffineTransform.identity
            self.chatbox.transform = CGAffineTransform.identity
            self.ASCLabel.text = "Check out our Association Feature by clicking on the Horse!"
            
        })
        
        UIView.animate(withDuration: 2, delay: 5, animations: { }) {(isComplete) in
            
        }
    }
    
    fileprivate func viewsAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.chatbox.transform = CGAffineTransform(translationX: 0, y: -30)
            self.arrow.transform = CGAffineTransform(translationX: 0, y: -30)
            self.confused.transform = CGAffineTransform(translationX: 0, y: 30)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.chatbox.alpha = 0
                self.arrow.alpha = 0
                self.confused.alpha = 0
                
                 self.chatbox.transform = self.chatbox.transform.translatedBy(x: 350, y: 0)
                self.confused.transform = self.arrow.transform.translatedBy(x: 350, y: 0)
                self.arrow.transform = self.arrow.transform.translatedBy(x: 0, y: -350)
                
                
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewsAnimation()
    }
    
    func  blurEffect () {
        effect = blurScreen.effect
        
    }
    

}

