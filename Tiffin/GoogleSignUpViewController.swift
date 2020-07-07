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

class GoogleSignUpViewController: UIViewController {
    

    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var dietChoiceVegan: UISegmentedControl!
    @IBOutlet weak var switchGlutenFree: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        errorMessage.textColor = UIColor.white
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dietChoice = dietChoiceVegan.selectedSegmentIndex
        let gfdiet = switchGlutenFree.isOn
        let fName = firstName.text
        let lName = lastName.text
        if segue.identifier == "profilePictureSegue"{
            
            let destination: ProfileViewController = segue.destination as! ProfileViewController
            // destination.currentEmail2 = currentEmail
            destination.foodType2 = dietChoice
            destination.glutenFree2 = gfdiet
            let name = usernameText.text
            destination.username2 = name!
            destination.oneName = fName!
            destination.twoName = lName!
            destination.cameFromGoogle = true
        }
        
        
    }
    
    
    // Temporary
    @IBAction func AllergySeguePerformer(_ sender: Any) {
        if (usernameText.text?.count)! < 7 {
            errorMessage.isHidden = false
        }
        else    {
        self.performSegue(withIdentifier: "profilePictureSegue", sender: self)
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
