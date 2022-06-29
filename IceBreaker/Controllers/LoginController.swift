//
//  LoginController.swift
//  practing
//
//  Created by shy attoun on 07/03/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit


class LoginController : UIViewController , GIDSignInUIDelegate,LoginButtonDelegate{
 
    let userDefault = UserDefaults.standard
    let btnGoogle = GIDSignInButtonColorScheme.dark

    @IBOutlet weak var googleBtn: GIDSignInButton!
    
    @IBOutlet weak var fbCustomeBtn: UIButton!

    @IBOutlet var LogViewController: UIView!
    
 
    @IBAction func fb(_ sender: Any) {
        FBsignInBtn()
    }
    
    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       googleBtn.layer.cornerRadius = 20
        GIDSignIn.sharedInstance().uiDelegate = self
          NotificationCenter.default.addObserver(self, selector: #selector (didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
  
    }
   
    override func viewDidAppear(_ animated: Bool) {


        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough"){
            print("view has been viewed before")
            return

        }

        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let  wtvc = storyboard.instantiateViewController(withIdentifier: "WTVC") as? WalkthroughViewController {
            present(wtvc, animated: true, completion: nil)
            print("onboarding storyboard is on")
        }

    }


    func FBsignInBtn() {
        
        let btnFBLogin = FBLoginButton( )
        

        btnFBLogin.translatesAutoresizingMaskIntoConstraints = false
        
        btnFBLogin.delegate = self
        btnFBLogin.permissions = ["public_profile","email","user_friends"]
        btnFBLogin.isHidden = true
        self.view.addSubview(btnFBLogin)
        btnFBLogin.sendActions(for: .touchUpInside)
        
        
        let accessToekn = AccessToken.current
        if  accessToekn != nil {
            print("LOGGED IN")
            print(accessToekn as Any)
         
        }else{
            print("not logged in")
        }
    }
    
    @objc func didSignIn()  {
    
       let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let homePageNav = UINavigationController (rootViewController: homePage)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = homePageNav
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    
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
            
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
       print("user LOGGED OUT")
    }
    
    
    func createUser (email:String , password: String) {
        if self.userEmail.text == "" || self.userPassword.text == "" {
            print("please fill all fields")
        }
        else{
            Auth.auth().createUser(withEmail: email, password: password) {(user,error) in
                if error == nil {
                    print("User created")
                    self.signInUser(email:email,password: password)
                }else{
                    print(error as Any)
                    print(error?.localizedDescription as Any)
                }
            }
    }
    }
    
    
    func signInUser (email:String  , password: String){
        
        if self.userEmail.text == "" || self.userPassword.text == "" {
            print("please fill all fields")
        }
        else {
            Auth.auth().signIn(withEmail: self.userEmail.text!, password: self.userPassword.text!){
                (user,error)in

                if error == nil {
                    print("you are succesfully signed in")
                    self.userDefault.set(true, forKey: "usersignedinwithemail")
                    self.userDefault.synchronize()
                    
                       let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    
                    let homePageNav = UINavigationController (rootViewController: homePage)
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    appDelegate.window?.rootViewController = homePageNav

                }
                else{
                    print(error as Any)
                    print(error?.localizedDescription as Any)
                }
            }
        }
        
}

    
    @IBAction func loginBtn(_ sender: UIButton) {
        if seg.selectedSegmentIndex == 0 {
            signInUser(email:userEmail.text!,password: userPassword.text!)
        }else if seg.selectedSegmentIndex == 1 {
            createUser(email:userEmail.text!,password: userPassword.text!)
        }
    }
    
    
    @IBAction func googleSignInBtn(_ sender: GIDSignInButton) {
    
        GIDSignIn.sharedInstance().signIn()
        
     
    }
}




