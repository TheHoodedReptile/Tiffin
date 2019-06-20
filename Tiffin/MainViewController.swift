//
//  MainViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 6/16/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import FirebaseUI

class MainViewController: UIViewController {

    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
        }
        
        // Do any additional setup after loading the view.
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
