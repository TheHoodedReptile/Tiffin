//
//  ChefLocationViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 8/11/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseFirestore

class ChefLocationViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneNumber2TextField: UITextField!
    @IBOutlet weak var phoneNumber3TextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var apartmentnumberTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    var db : Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
 
    var address = "10 Lombard Street, San Francisco"
    

    
    @IBAction func continueButtonPressed(_ sender: Any) {
        let textFieldArray = [streetAddressTextField.text, cityTextField.text, stateTextField.text]
        let phoneNumber = (Int(phoneNumberTextField.text!))
        let phoneNumber2 =  (Int(phoneNumber2TextField.text!))
        let phoneNumber3 = (Int(phoneNumber3TextField.text!))
        let phoneNumberStringForm = "(\(phoneNumberTextField.text!))\(phoneNumber2TextField.text!)-\(phoneNumber3TextField.text!)"
        if textFieldArray.isEmpty == false  {
            address = "\(streetAddressTextField.text!), \(cityTextField.text!), \(stateTextField.text!), \(zipCodeTextField.text!)"
            print(address)
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    else {
                        return
                }
                
                self.db.collection("users").document(goatUser!).collection("userInfo").document("location").setData([
                    "location": GeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                    "isChef" : true
                    ], merge: true)
                self.db.collection("locations").document(goatUser!).setData([
                    "location": GeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude),
                    "owner": goatUser!,
                    "phoneNumber": phoneNumber!,
                    "phoneNumber2": phoneNumber2!,
                    "phoneNumber3": phoneNumber3!,
                    "phoneNumberString": phoneNumberStringForm,
                    ], merge: true)
                self.performSegue(withIdentifier: "nextStepChefRegister", sender: self)
            }
        }
    }
    
    @IBAction func firstPhoneNumberTextFieldChanged(_ sender: Any) {
        updatePhoneNumberTextField(textField: phoneNumberTextField, text2Field: phoneNumber2TextField)
    }
    
    @IBAction func secondPhoneNumberTextFieldChanged(_ sender: Any) {
        updatePhoneNumberTextField(textField: phoneNumber2TextField, text2Field: phoneNumber3TextField)
    }
    
    @IBAction func thirdPhoneNumberChanged(_ sender: Any) {
    }
    
    func updatePhoneNumberTextField(textField : UITextField, text2Field : UITextField) {
        if textField.text!.count >= 3 {
            text2Field.becomeFirstResponder()
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
