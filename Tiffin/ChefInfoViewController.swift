//
//  ChefInfoViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 8/11/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ChefInfoViewController: UIViewController {

    @IBOutlet weak var personalDescriptionTextView: UITextView!
    @IBOutlet weak var cuisineTextField: UITextField!
    @IBOutlet weak var placeNameField: UITextField!
    @IBOutlet weak var chefExperienceTextField: UITextField!
    @IBOutlet weak var extraCuisineField: UITextField!

    var db : Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.db.collection("locations").document(goatUser!).setData([
            "name": placeNameField.text!
            ], merge: true)
        performSegue(withIdentifier: "homeSegue", sender: self)
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
