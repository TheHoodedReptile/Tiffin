//
//  SignInViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 6/14/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import FirebaseUI

class SignInViewController: UIViewController {

    
    // MARK: Constants
    let loginToList = "loginSegue"
    
    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Actions
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        guard
            let email = textFieldLoginEmail.text,
            let password = textFieldLoginPassword.text,
            email.count > 0,
            password.count > 0
            else {
                return
        }

        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
                // self.ImageIndicator.image = UIImage (named: "phone2")
            }
            else    {
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        Auth.auth().addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                // 3
                self.performSegue(withIdentifier: "userInfoSegue", sender: nil)
                self.textFieldLoginEmail.text = nil
                self.textFieldLoginPassword.text = nil
                // self.ImageIndicator.image = UIImage (named: "phone3")
            }
                    }
    }
    
    var email = ""
    
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            self.email = emailField.text!
            // 2
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error == nil {
                    // 3
                    
                    Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!,
                                       password: self.textFieldLoginPassword.text!)
                    self.performSegue(withIdentifier: "userInfoSegue", sender: self)
                    
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userInfoSegue"   {
            
            let destination: UserInfoViewController = segue.destination as! UserInfoViewController
            destination.currentEmail = email
        }
        
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
            print("2")
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
            print("3")
        }
        return true
    }
}
