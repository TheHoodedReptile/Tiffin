//
//  ViewController.swift
//  mapTester
//
//  Created by Shaurya Pathak on 7/29/19.
//  Copyright © 2019 WhitneyMediaCommunications. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore
import FirebaseUI

class MapViewController: UIViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var mapKitOutlet: MKMapView!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var darkGrayView: UIView!
    @IBOutlet weak var dTrailing: NSLayoutConstraint!
    @IBOutlet weak var dLeading: NSLayoutConstraint!
    @IBOutlet weak var firstAndLastName: UILabel!
    
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var stackViewShowing = false
    var db : Firestore!
    var docRef : DocumentReference!
    var locationLatitude = 0.0
    var locationLongitude = 0.0
    let storage = Storage.storage()
    var isAChef = false
    var something = 0
    var documentArray : [QueryDocumentSnapshot] = []
    var mealArray : [QueryDocumentSnapshot] = []
    var locationArray : [QueryDocumentSnapshot] = []
    var counter = 0
    var mealName = ""
    var newTag = 0
    var nameText = "Looking Good"
    
    
    // Puts where you start on the map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latitude = locValue.latitude
        longitude = locValue.longitude
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        print(longitude)
        print(latitude)
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        centerMapOnLocation(location: initialLocation)
    }
    
    func getMeals ()    {
        print("Get meals ran")
        self.db.collection("locations").getDocuments { (querySnapshot, err) in
            if let err = err{
                print("Error getting document \(err)")
            }
            else    {
                for document in querySnapshot!.documents    {
                    self.locationArray.append(document)
                }
                print(self.locationArray)
            }
            self.mealAppend()
        }
    }
    
    func mealAppend() {
        for i in self.locationArray  {
            self.db.collection("locations").document("\(i.documentID)").collection("meals").getDocuments(completion: { (secondQuerySnapshot, err) in
                for mealDocument in secondQuerySnapshot!.documents  {
                    self.mealArray.append(mealDocument)
                    let mealData = mealDocument.data()
                    self.mealName = mealData["mealName"] as! String
                }
            })

        }
                    self.setAnnotations()
    }
    
    func setAnnotations ()  {
        print("set annotations ran")
        print("Location Array Data: \(locationArray)")
        for locationInfo in locationArray   {
            let myData = locationInfo.data()
            let placeName = myData["name"] as! String
            let mealOwner = myData["owner"] as! String
            let location = myData["location"]
            print("This is the data: \(myData)")
            let point = location as! GeoPoint
            self.locationLatitude = point.latitude
            self.locationLongitude = point.longitude
            print("Location Array Contents \(locationArray)")
            print("Tagged \(counter)")
            let artwork = Artwork(
                title: placeName,
                locationName: mealName,
                discipline: mealOwner,
                coordinate: CLLocationCoordinate2D(latitude: self.locationLatitude, longitude: self.locationLongitude),
                tag: counter
            
            )
            self.mapKitOutlet.addAnnotation(artwork)
            counter += 1
            
        }
        print("Counter:\(counter)")
        print("MealArray Count \(mealArray.count)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View did load just went")
        db = Firestore.firestore()
        // Do any additional setup after loading the view, typically from a nib.
        // set initial location in Honolulu
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.layer.cornerRadius = 41.5
        mapKitOutlet.tintColor = UIColor.orange
        getDocuments()
        checkLocationAuthorizationStatus()
        setUpDelegates()
    }
    
    func getDocuments   ()  {
        
        self.db.collection("locations").getDocuments() { (querySnapshot, err) in
            self.getMeals()
            
            // Reference to an image file in Firebase Storage
            let storageRef = self.storage.reference()
            let profileRef = storageRef.child("\(goatUser!).png")
            
            // UIImageView in your ViewController
            profileRef.getData(maxSize: 2 * 2048 * 2048) { data, error in
                if let error = error {
                    // Uh-oh, an error occurred!
                    print(error.localizedDescription)
                } else {
                    // Data for "images/island.jpg" is returned
                    let image = UIImage(data: data!)
                    self.profilePictureImageView.image = image
                }
            }
            
            let docRef = self.db.collection("users").document(goatUser!).collection("userInfo").document("location")
            
            docRef.getDocument { (docSnapshot, error) in
                guard let docSnapshot = docSnapshot, docSnapshot.exists else {return}
                let myData = docSnapshot.data()
                self.isAChef = (myData!["isChef"] as? Bool)!
                if self.isAChef == true {
                    self.greenButton.setTitle("Chef  Menu", for: .normal)
                    print("done")
                    
                }
                else    {
                    print("ig it false")
                }
            }
            let userNameRef = self.db.collection("users").document(goatUser!).collection("userInfo").document("Username")
            userNameRef.getDocument { (docSnapshot, error) in
                guard let docSnapshot = docSnapshot, docSnapshot.exists else {return}
                let myData = docSnapshot.data()
                let firstName = myData!["firstName"]
                let lastName = myData!["lastName"]
                let fullName = "\(String(describing: firstName!)) \(String(describing: lastName!))"
                self.nameText = fullName
                self.firstAndLastName.text = self.nameText
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "successfulSegue"    {
            let destination: ChefMealViewController = segue.destination as! ChefMealViewController
            // destination.currentEmail2 = currentEmail
            destination.userSnapshot = locationArray[newTag]
        }
    }
    // Also sets defaults but slightly after
    /*override func viewDidAppear(_ animated: Bool) {
        
        
    }*/
    func setUpDelegates ()  {
    
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        mapKitOutlet.delegate = self
        
        
    
    }
    // Sets defaults
    
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapKitOutlet.setRegion(coordinateRegion, animated: false)
    }
    
    // Menu Slide In Functionality
    @IBAction func buttonPressed(_ sender: Any) {
        if !stackViewShowing    {
            leading.constant = 300
            trailing.constant = 300
            print(view.tag)
            stackViewShowing = true
            darkGrayView.layer.zPosition = 1000
            dLeading.constant = 300
            dTrailing.constant = 300
            let origImage = UIImage(named: "menuicon")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            buttonOutlet.setImage(tintedImage, for: .normal)
            buttonOutlet.tintColor = .white
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                
                self.darkGrayView.alpha = 0.7
                
            }, completion: nil)
            
        }
        else    {
            leading.constant = 0
            trailing.constant = 0
            stackViewShowing = false
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                
                self.darkGrayView.alpha = 0.0
                
            }, completion: { complete in
                self.darkGrayView.layer.zPosition = -1000
            })
            
            dLeading.constant = 0
            dTrailing.constant = 0
            
            let btnImage = UIImage(named: "menuicon")
            buttonOutlet.setImage(btnImage , for: UIControl.State.normal)
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("Animation Complete!")
        }
    }
    
    @IBAction func recog(_ sender: Any) {
        print("Maybe")
    }
    
    // Checks if location has been allowed
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapKitOutlet.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func tempButtonPushed(_ sender: Any) {
        
        print(locationLongitude)
        
    }
    
    @IBAction func registerChefPressed(_ sender: Any) {
        if isAChef  {
            performSegue(withIdentifier: "chefMenuSegue", sender: self)
        }
        else    {
        performSegue(withIdentifier: "registerAsChefSegue", sender: self)
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            try goatUser = ""
            try performSegue(withIdentifier: "signOutStartScreen", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
}

// Extension that makes sure everything is easier to use
extension MapViewController: MKMapViewDelegate {
    // 1
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
            view.glyphImage = UIImage(named: "TiffinIcon")
            view.markerTintColor = UIColor.orange
        }
        else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.glyphImage = UIImage(named: "TiffinIcon")
            view.markerTintColor = UIColor.orange
            //view.tag = counter
            let btn = UIButton(type: .detailDisclosure)
            btn.setImage(UIImage(named: "TiffinIcon"), for: .normal)
            view.rightCalloutAccessoryView = btn
            //view.tag = counter
            print("counter tagged:\(counter)")
            
            
        }
        return view
    }
    //Button Clicked Function
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? Artwork {
            print("This is the \(annotation.tag)")
            newTag = annotation.tag
            performSegue(withIdentifier: "successfulSegue", sender: self)
        }
    }
}

