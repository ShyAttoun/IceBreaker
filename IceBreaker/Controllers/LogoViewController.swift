//
//  LogoViewController.swift
//  IceBreaker
//
//  Created by shy attoun on 18/07/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseCore
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit

class LogoViewController: UIViewController , GIDSignInUIDelegate ,LoginButtonDelegate{
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error?.localizedDescription as Any)
        }else if (result?.isCancelled)! {
            print("User cancelled log in")
        }else{
            print("user LOGGED IN succesfully")
            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            let homePageNav = UINavigationController (rootViewController: homePage)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = homePageNav
            
        }
        if (result?.grantedPermissions.contains("email"))! {
            // Do work
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("user LOGGED OUT")
    }
    
    var player: AVAudioPlayer?
    let userDefault = UserDefaults.standard

    
    @IBOutlet weak var horseLogo: UIImageView!
    
    @IBOutlet weak var iceLogo: UIImageView!
    
    @IBOutlet weak var icebreakerLogo: UIImageView!
    
    @IBOutlet weak var iceLogoBottomCont: NSLayoutConstraint!
    @IBOutlet weak var horseLogoTopConst: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
    logoAnimate()
        
    
    }
    
    func logoAnimate () {
        iceLogoBottomCont.constant += 160
        horseLogoTopConst.constant += 250
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options:[], animations: {
            self.playSaveSound()
            self.view.layoutIfNeeded()}) {(isComplete) in
                if (self.userDefault.bool(forKey: "usersignedin")){
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    let homePageNav = UINavigationController (rootViewController: homePage)
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    appDelegate.window?.rootViewController = homePageNav
                    print("YALLLA YALLA")
                    //             performSegue(withIdentifier: "Home", sender: self)
                }
                else if (AccessToken.current != nil)
                {
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    let homePageNav = UINavigationController (rootViewController: homePage)
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    appDelegate.window?.rootViewController = homePageNav
                    //            performSegue(withIdentifier: "Home", sender: self)
                }else if (self.userDefault.bool(forKey: "usersignedinwithemail")){
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    let homePageNav = UINavigationController (rootViewController: homePage)
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    appDelegate.window?.rootViewController = homePageNav
                }
                    
                    
                else{
                    print("oyvey!")
                     self.performSegue(withIdentifier: "animatetologin", sender: nil)
                }
                
    
                
               
        }
    }
    


    func playSaveSound(){
        let path = Bundle.main.path(forResource: "bounce.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            //create your audioPlayer in your parent class as a property
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("couldn't load the file")
        }
    }
    
    
  
}
