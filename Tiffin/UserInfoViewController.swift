//
//  UserInfoViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 6/25/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

var currentEmail : String = String()

class UserInfoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var errorMessage3: UILabel!
    @IBOutlet weak var errorMessage2: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordSignUpTextField: UITextField!
    @IBOutlet weak var emailSignUpTextField: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var dietChoiceVegan: UISegmentedControl!
    @IBOutlet weak var switchGlutenFree: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textFieldArray = [firstName, lastName, confirmPasswordTextField, passwordSignUpTextField, usernameText]
        for i in textFieldArray {
            i!.delegate = self
        }
        // Do any additional setup after loading the view.
        errorMessage.isHidden = true
        errorMessage2.isHidden = true
        errorMessage3.isHidden = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fName = firstName.text
        let lName = lastName.text
        let dietChoice = dietChoiceVegan.selectedSegmentIndex
        let gfdiet = switchGlutenFree.isOn
        if segue.identifier == "ProfilePicSegue"{
            
            let destination: ProfileViewController = segue.destination as! ProfileViewController
            // destination.currentEmail2 = currentEmail
            destination.foodType2 = dietChoice
            destination.glutenFree2 = gfdiet
            let name = usernameText.text
            destination.username2 = name!
            destination.oneName = fName!
            destination.twoName = lName!
        }
        
        
    }

    
    // Temporary
    @IBAction func AllergySeguePerformer(_ sender: Any) {
        print("1")
        let emailField = emailSignUpTextField
        let passwordField = passwordSignUpTextField
        //self.email = emailField.text!
        // 2
        if usernameText.text!.count > 7 && passwordSignUpTextField.text == confirmPasswordTextField.text && (firstName.text!.count + lastName.text!.count) > 5    {
        Auth.auth().createUser(withEmail: emailField!.text!, password: passwordField!.text!) { user, error in
            if error == nil {
                // 3
                
                Auth.auth().signIn(withEmail: self.emailSignUpTextField.text!,
                                   password: self.passwordSignUpTextField.text!)
                currentEmail = self.emailSignUpTextField.text!
                self.performSegue(withIdentifier: "ProfilePicSegue", sender: self)
                print("2")
            }
            else    {
                print("3")
                self.errorMessage3.isHidden = false
                print(error?.localizedDescription)
            }
        }
            let actionCodeSettings = ActionCodeSettings()
            actionCodeSettings.url = URL(string: "https://www.example.com")
            // The sign-in operation has to always be completed in the app.
            actionCodeSettings.handleCodeInApp = true
            actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
            actionCodeSettings.setAndroidPackageName("com.example.android",
                                                     installIfNotAvailable: false, minimumVersion: "12")
            // [END action_code_settings]
            // [START send_signin_link]
            let email = emailField?.text
            Auth.auth().sendSignInLink(toEmail:email!,
               actionCodeSettings: actionCodeSettings) { error in
                // [START_EXCLUDE]
                    // [END_EXCLUDE]
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    // The link was successfully sent. Inform the user.
                    // Save the email locally so you don't need to ask the user for it again
                    // if they open the link on the same device.
                    UserDefaults.standard.set(email, forKey: "Email")
                    //self.showMessagePrompt("Check your email for link")
                    // [START_EXCLUDE]
                // [END_EXCLUDE]
            
                // The link was successfully sent. Inform the user.
                // Save the email locally so you don't need to ask the user for it again
                // if they open the link on the same device.
                //UserDefaults.standard.set(email, forKey: "Email")
                //self.showMessagePrompt("Check your email for link")
                // [START_EXCLUDE]
            // [END_EXCLUDE]
}
            
        }
        if usernameText.text!.count <= 7 {
        errorMessage.isHidden = false
        }
        if passwordSignUpTextField.text != confirmPasswordTextField.text    {
            errorMessage2.isHidden = false
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
