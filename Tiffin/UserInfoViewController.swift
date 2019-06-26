//
//  UserInfoViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 6/25/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    var currentEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AllergySegue"   {
            
            let destination: AllergyViewController = segue.destination as! AllergyViewController
            destination.currentEmail2 = currentEmail
            var name = usernameText.text
            destination.username = name!
        }
        
    }

    
    // Temporary
    @IBAction func AllergySeguePerformer(_ sender: Any) {
        performSegue(withIdentifier: "AllergySegue", sender: self)
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
