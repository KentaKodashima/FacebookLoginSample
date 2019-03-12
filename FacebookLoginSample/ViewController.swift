//
//  ViewController.swift
//  FacebookLoginSample
//
//  Created by Kenta Kodashima on 2019-03-11.
//  Copyright © 2019 Kenta Kodashima. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
   
//    let loginButton = FBSDKLoginButton()
//    loginButton.delegate = self
    
    // Optional: Place the button in the center of your view.
//    loginButton.center = view.center
//    view.addSubview(loginButton)
    
    if (FBSDKAccessToken.current() != nil) {
      // User is logged in, do work such as go to next view controller.
    }
    
    //
//    loginButton.readPermissions = ["public_profile", "email"]
  }
  
  @IBAction func facebookLogin(sender: AnyObject) {
    let LoginManager = FBSDKLoginManager()
    
    LoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
      
      if let error = error {
        print("Failed to login: \(error.localizedDescription)")
        return
      }
      guard let accessToken = FBSDKAccessToken.current() else {
        print("Failed to get access token")
        return
      }
      let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
      // Perform login by calling Firebase APIs
      Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
        if let error = error {
          print("Login error: \(error.localizedDescription)")
          let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
          let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertController.addAction(okayAction)
          self.present(alertController, animated: true, completion: nil)
          return
        }
        // self.performSegue(withIdentifier: self.signInSegue, sender: nil)
      }
    }
  }
  
  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    if let error = error {
      print(error.localizedDescription)
      return
    }
    
    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
    
    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
      if let error = error {
        // ...
        return
      }
      // User is signed in
      // ...
    }
    // ...
  }
  
  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    // Do something when the user logout
    print("Logged out")
  }
}

