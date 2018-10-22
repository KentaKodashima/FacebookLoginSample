//
//  ViewController.swift
//  FacebookLoginExample
//
//  Created by Kenta Kodashima on 2018-10-20.
//  Copyright © 2018 Kenta Kodashima. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let loginButton = FBSDKLoginButton()
    loginButton.delegate = self
    // Optional: Place the button in the center of your view.
    loginButton.center = view.center
    view.addSubview(loginButton)
    
    if (FBSDKAccessToken.current() != nil) {
      // User is logged in, do work such as go to next view controller.
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
    print("Logged out")
  }


}

