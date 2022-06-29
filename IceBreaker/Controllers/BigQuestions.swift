//
//  BigQuestions.swift
//  practing
//
//  Created by shy attoun on 13/03/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import SVProgressHUD
import  Lottie




struct Questions:Decodable {
    let id: Int
    let setup: String
}

class BigQuestions: UIViewController {

    private var question = [Questions] ()
    
    @IBOutlet var lotAnimateScreen: AnimationView!
    @IBOutlet weak var blurScreen: UIVisualEffectView!
    @IBOutlet weak var chatText: UITextView!
    @IBOutlet weak var chatbox: UIView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var quesGuy: UIImageView!
    @IBOutlet weak var questionLabel: UITextView!
    @IBOutlet weak var randomBtn: UIButton!
    
    
    @IBOutlet var BQviewController: UIView!
    
    var effect: UIVisualEffect!

    override func viewDidLoad() {
        super.viewDidLoad()
        
         downloadJsonQues ()
        blurEffect ()
        startAnimation()
        viewsDesign()
        imageSlideIn()
    }
    
    @IBAction func showRandomQuestionBtn(_ sender: UIButton) {
       
       showRandImageAndQuestion ()
        viewAnimation()
    }

    func showRandImageAndQuestion () {
        let randomQuestion = question.randomElement()
        questionLabel.text = randomQuestion?.setup
    }
    
    func downloadJsonQues () {
        
        let url = "https://icebreakerappinc.herokuapp.com/questions"
        
        //creating let for the url to bond with the link above #2
        guard let url2  = URL (string: url) else {return}
        URLSession.shared.dataTask(with: url2) { (data,response,err) in
            guard let data = data else {return}
            
            do {
                let setup = try JSONDecoder().decode([Questions].self, from: data)
                
                DispatchQueue.main.async {
                    self.BQviewController.reloadInputViews()
                    self.question = setup
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
        randomBtn.layer.cornerRadius = 25
        quesGuy.layer.shadowColor = UIColor.black.cgColor
        quesGuy.layer.shadowOffset = CGSize (width: 5 , height: 3)
        quesGuy.layer.shadowRadius = 4
        quesGuy.layer.shadowOpacity = 1.5
        
    
    }
    
    func imageSlideIn () {
        view.addSubview(quesGuy)
        view.addSubview(arrow)
        view.addSubview(chatbox)
        
        arrow.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0, y: -400)
        
        chatbox.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: 0, y: -400)
        
        quesGuy.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).translatedBy(x: -500, y: -20)
        
        UIView.animate(withDuration: 1, delay: 3,usingSpringWithDamping: 20, initialSpringVelocity: 0.5, options:[], animations: {
            self.quesGuy.transform = CGAffineTransform.identity
            self.arrow.transform = CGAffineTransform.identity
            self.chatbox.transform = CGAffineTransform.identity
            self.chatText.text = "Check out our Big Questions Feature by clicking on the Horse!"
            
        })
        
        UIView.animate(withDuration: 2, delay: 5, animations: { }) {(isComplete) in
            
        }
    }
    
    fileprivate func viewAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.arrow.transform = CGAffineTransform(translationX: 0, y: -30)
            
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.quesGuy.alpha = 0
                self.arrow.alpha = 0
                self.chatbox.alpha = 0
                
                self.quesGuy.transform = self.quesGuy.transform.translatedBy(x: 0, y: -350)
                
                self.arrow.transform = self.arrow.transform.translatedBy(x: 0, y: -350)
                
                self.chatbox.transform = self.chatbox.transform.translatedBy(x: 0, y: -350)
                
                
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



