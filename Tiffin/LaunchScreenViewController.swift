//
//  LaunchScreenViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 6/15/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if goatUser != nil  {
            print("ned")
            performSegue(withIdentifier: "defaultSegue", sender: self)
        }
        else    {
            performSegue(withIdentifier: "firstSegue", sender: self)
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
