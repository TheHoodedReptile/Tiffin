//
//  AllergyViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 6/14/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseDatabase


class AllergyViewController: UIViewController {

    
    // Declaration of Outlets
    
    @IBOutlet weak var peanutSwitch: UISwitch!
    @IBOutlet weak var soySwitch: UISwitch!
    @IBOutlet weak var shellfishSwitch: UISwitch!
    @IBOutlet weak var fishSwitch: UISwitch!
    @IBOutlet weak var dairySwitch: UISwitch!
    @IBOutlet weak var eggSwitch: UISwitch!
    @IBOutlet weak var treeNutSwitch: UISwitch!
    @IBOutlet weak var wheatSwitch: UISwitch!
    
    // var docRef: DocumentReference!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
    }
    
    var username = ""
    var foodType = 2
    var glutenFree = false
    var db: Firestore!
    var firstName = ""
    var lastName = ""
    // Sets default values for whether their are allergies to False
    // Foodtype 2 = Not Vegan/Veg
    // Food type 1 = Vegetarian
    // Food type 0 = Vegan
    
    

    
    // Sets allergy data for user when next button is tapped
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        let peanutAllergyInd = peanutSwitch.isOn
        let dairyAllergyInd = dairySwitch.isOn
        let soyAllergyInd = soySwitch.isOn
        let eggAllergyInd = eggSwitch.isOn
        let shellfishAllergyInd = shellfishSwitch.isOn
        let treeNutAllergyInd = treeNutSwitch.isOn
        let fishAllergyInd = fishSwitch.isOn
        let wheatAllergyInd = wheatSwitch.isOn
       
        db.collection("users").document(goatUser!).collection("userInfo").document("Allergies").setData([
            "dairy": dairyAllergyInd,
            "eggs": eggAllergyInd,
            "fish": fishAllergyInd,
            "peanuts": peanutAllergyInd,
            "shellfish": shellfishAllergyInd,
            "soy": soyAllergyInd,
            "treeNuts": treeNutAllergyInd,
            "wheat": wheatAllergyInd,
            "vegetarian_vegan": foodType,
            "isGlutenFree": glutenFree
        ])
        db.collection("users").document(goatUser!).collection("userInfo").document("Username").setData([
            "Username": username,
            "firstTimeLogIn": "false",
            "firstName": firstName,
            "lastName": lastName,
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        performSegue(withIdentifier: "finishRegister", sender: self)
        
    }
    
    
    
    
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishRegister"  {
            let destination: MapViewController = segue.destination as! MapViewController
            destination.userEmail = currentEmail2
        }
    } */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
