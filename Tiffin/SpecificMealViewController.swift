//
//  SpecificMealViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 9/8/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore
import FirebaseUI

class SpecificMealViewController: UIViewController {
    
    @IBOutlet weak var mealTextName: UILabel!
    @IBOutlet weak var mealDescription: UILabel!
    @IBOutlet weak var mealAllergies: UILabel!
    @IBOutlet weak var mealCuisine: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var orangeBackground: UIView!
    
    var venueLat = 0.0
    var venueLng = 0.0
    var mealName : String!
    var mealLocation : CLLocationCoordinate2D!
    var mealChosen : Meal!
    var db : Firestore!
    var docRef : DocumentReference!
    let storage = Storage.storage()
    var mealOwnerId : String!
    var mealNumber : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        venueLat = mealLocation.latitude
        venueLng = mealLocation.longitude
        db = Firestore.firestore()
        docRef = db.collection("locations").document("location2")
        let mealInfo = mealChosen.document.data()
        mealDescription.text = mealInfo["foodDescription"] as? String
        mealAllergies.text = mealInfo["Allergies"] as? String
        mealCuisine.text = mealInfo["Cuisine"] as? String
        mealTextName.text = mealInfo["mealName"] as? String
        let storageRef = self.storage.reference()
        let profileRef = storageRef.child("mealImages/\(mealOwnerId!)/\(mealInfo["mealName"] as! String)/\(mealNumber!).png")
        
        let path = UIBezierPath(roundedRect: orangeBackground.bounds, byRoundingCorners: [UIRectCorner.bottomLeft , UIRectCorner.bottomRight], cornerRadii: CGSize(width: 30, height: 30))
        let masklayer = CAShapeLayer()
        masklayer.path = path.cgPath
        orangeBackground.layer.mask = masklayer
        
        // UIImageView in your ViewController
        profileRef.getData(maxSize: 2 * 2048 * 2048) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error.localizedDescription)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.mealImage.image = image
            }
        }
        // Do any additional setup after loading the view.
    }
/*
     //Get Directions Button DEVELOPER - USE SOMEWHERE ELSE
    
    @IBAction func getDirections(_ sender: Any) {
            
            let latitude:CLLocationDegrees =  self.venueLat
            let longitude:CLLocationDegrees =  self.venueLng
            
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = mealName
            mapItem.openInMaps(launchOptions: options)
        
    }
  */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
