//  AppDelegate.swift
//  practing
//
//  Created by shy attoun on 03/03/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {

    var window: UIWindow?
    let userDefault = UserDefaults()
    
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
            return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            guard let authentication = user.authentication else {return}
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
          
            Auth.auth().signIn(with: credential) {(result,error) in
                if error  == nil {
                    self.userDefault.set(true, forKey: "usersignedin")
                    self.userDefault.synchronize()
                    
                    NotificationCenter.default.post(
                        name: Notification.Name("SuccessfulSignInNotification"), object: nil, userInfo: nil)
//                    self.window?.rootViewController?.performSegue(withIdentifier: "segToHome", sender: nil)
                } else {
                    print(error?.localizedDescription as Any)
                }
            }
        }
            
        }
    
    
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if  error == nil {
                // ...
                self.userDefault.set(true, forKey: "usersignedinwithfb")
                self.userDefault.synchronize()
             
//                self.window?.rootViewController?.performSegue(withIdentifier: "SegueToHome", sender: nil)
            }else{
                 print(error?.localizedDescription as Any)
            }
        }

    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = ApplicationDelegate.shared.application(app, open: url, options: options)
        return handled
    }
    
  
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    



