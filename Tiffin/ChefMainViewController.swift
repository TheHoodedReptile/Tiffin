//
//  ChefMainViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 8/13/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseUI

class ChefMainViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIButton!
    
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storageRef = self.storage.reference()
        let profileRef = storageRef.child("\(goatUser!).png")
        profileRef.getData(maxSize: 2 * 2048 * 2048) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error.localizedDescription)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.profilePicture.setImage(image, for: .normal)
            }
        }
        profilePicture.layer.cornerRadius = (profilePicture.bounds.size.height / 2.0)
        profilePicture.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func profilePicturePressed(_ sender: Any) {
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
