//
//  uploadFileViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 8/16/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class uploadFileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var cuisine: UITextField!
    @IBOutlet weak var foodDescription: UITextView!
    @IBOutlet weak var peanutSwitch: UISwitch!
    @IBOutlet weak var dairySwitch: UISwitch!
    @IBOutlet weak var eggSwitch: UISwitch!
    @IBOutlet weak var shellFishSwitch: UISwitch!
    @IBOutlet weak var soySwitch: UISwitch!
    @IBOutlet weak var treeNutSwitch: UISwitch!
    @IBOutlet weak var fishSwitch: UISwitch!
    @IBOutlet weak var wheatSwitch: UISwitch!
    @IBOutlet weak var mealNameTextField: UITextField!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var costPrice: UITextField!
    
    var db : Firestore!
    var longitude = 0.0
    var latitude = 0.0
    var imagePicker = UIImagePickerController()
    var indexImagePicker = 0
    var img : [UIImageView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        db = Firestore.firestore()
        img = [mainImageView, secondImageView, thirdImageView]
        /*docRef.getDocument { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists else {return}
            let myData = docSnapshot.data()
            let point = (myData!["location"] as? GeoPoint)!
            self.latitude = point.latitude
            self.longitude = point.longitude
        }*/
        
        

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadButtonPressed(_ sender: Any) {
        
        let switchArray = [peanutSwitch, dairySwitch, eggSwitch, shellFishSwitch, soySwitch, treeNutSwitch, fishSwitch, wheatSwitch]
        let decoder = ["Peanuts", "Dairy", "Eggs", "ShellFish", "Soy", "Treenuts", "Fish", "Wheat"]
        var onSwitchArray : [String] = []
        var index = 0
        for i in switchArray    {
            if i?.isOn == true   {
                onSwitchArray.append(decoder[index])
            }
            index += 1
        }
        let mealName = mealNameTextField.text
        let docRef = self.db.collection("locations").document(goatUser!).collection("meals").document(mealName!)
        docRef.setData([
            "Allergies": onSwitchArray,
            "Cuisine": cuisine.text!,
            "foodDescription": foodDescription.text,
            "mealName": mealName!,
            "cost" : costPrice.text!,
            ], merge: true)
        
        
        
        for i in 0...2  {
            let storageRef = Storage.storage().reference().child("mealImages/\(goatUser!)/\(mealName!)/\(i).png")
            if let uploadData = self.img[i].image?.pngData() {
            
            storageRef.putData(uploadData, metadata: nil) { ( metadata, error ) in
                if error != nil {
                    return
                } else {
                    
                }
            }
        }
    }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            img[indexImagePicker].image = image
            
        }
        else    {
            print("fail")
        }
        dismiss(animated: true, completion: nil)
        //img.layer.cornerRadius = img.frame.size.height / 2
        
        
        
    }
    
    @IBAction func mainImagePressed(_ sender: Any) {
        indexImagePicker = 0
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        print("Veni")
        
    }
    @IBAction func secondImagePressed(_ sender: Any) {
        indexImagePicker = 1
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        print("Vidi")
        
    }
    @IBAction func thirdImagePressed(_ sender: Any) {
        indexImagePicker = 2
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        print("Vici")
        
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
