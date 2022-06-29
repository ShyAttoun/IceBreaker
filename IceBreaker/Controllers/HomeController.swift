//
//  HomeController.swift
//  practing
//
//  Created by shy attoun on 07/03/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit
import MessageUI



class HomeViewController : UIViewController {
    
    let userDefault = UserDefaults.standard
    
   
    @IBOutlet weak var pickupBtn: UIButton!

    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var bigQuesBtn: UIButton!
    @IBOutlet weak var ascBtn: UIButton!

    @IBOutlet weak var funFactsBtn: UIButton!
    @IBOutlet weak var wdypBtn: UIButton!
    @IBOutlet weak var jokesBtn: UIButton!
    
    @IBOutlet var homeVC: UIView!
    
    @IBAction func signOut(_ sender: UIButton) {
        signOutFromApp()
    }
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem  = UIBarButtonItem(title: "Sign out", style: .done, target: self , action: #selector(signOutFromApp))
       buttonsDesign()
        
        self.homeVC.backgroundColor = .lightGray
        
    }
    
    func buttonsDesign (){
        pickupBtn.layer.cornerRadius = 12
        wdypBtn.layer.cornerRadius = 12
        ascBtn.layer.cornerRadius = 12
        bigQuesBtn.layer.cornerRadius = 12
        funFactsBtn.layer.cornerRadius = 12
        jokesBtn.layer.cornerRadius = 12
        contactBtn.layer.cornerRadius = 12
        
        pickupBtn.layer.shadowColor = UIColor.black.cgColor
        pickupBtn.layer.shadowOffset = CGSize (width: 2 , height: 3)
        pickupBtn.layer.shadowRadius = 4
        pickupBtn.layer.shadowOpacity = 0.5
        
        contactBtn.layer.shadowColor = UIColor.black.cgColor
        contactBtn.layer.shadowOffset = CGSize (width: 2 , height: 3)
        contactBtn.layer.shadowRadius = 4
        contactBtn.layer.shadowOpacity = 0.5
        
        bigQuesBtn.layer.shadowColor = UIColor.black.cgColor
        bigQuesBtn.layer.shadowOffset = CGSize (width: 2 , height: 3)
        bigQuesBtn.layer.shadowRadius = 4
        bigQuesBtn.layer.shadowOpacity = 0.5
        
        ascBtn.layer.shadowColor = UIColor.black.cgColor
        ascBtn.layer.shadowOffset = CGSize (width: 2 , height: 3)
        ascBtn.layer.shadowRadius = 4
        ascBtn.layer.shadowOpacity = 0.5
        
        wdypBtn.layer.shadowColor = UIColor.black.cgColor
        wdypBtn.layer.shadowOffset = CGSize (width: 2 , height: 3)
        wdypBtn.layer.shadowRadius = 4
        wdypBtn.layer.shadowOpacity = 0.5
        
        funFactsBtn.layer.shadowColor = UIColor.black.cgColor
        funFactsBtn.layer.shadowOffset = CGSize (width: 2 , height: 3)
        funFactsBtn.layer.shadowRadius = 4
        funFactsBtn.layer.shadowOpacity = 0.5
        
        jokesBtn.layer.shadowColor = UIColor.black.cgColor
        jokesBtn.layer.shadowOffset = CGSize (width: 2 , height: 3)
        jokesBtn.layer.shadowRadius = 4
        jokesBtn.layer.shadowOpacity = 0.5
        
    }
    
    @objc func signOutFromApp () {
        do{
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance().signOut()
            
            let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
            let loginPageNav = UINavigationController (rootViewController: loginPage)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = loginPageNav
            
            AccessToken.current = nil
            userDefault.removeObject(forKey: "usersignedin")
            userDefault.removeObject(forKey: "usersignedinwithfb")
            userDefault.removeObject(forKey: "usersignedinwithemail")
            print("user is LOGGED OUT")
            userDefault.synchronize()
            self.dismiss(animated: true, completion: nil)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
}



