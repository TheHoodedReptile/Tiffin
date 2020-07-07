//
//  ChefMealViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 8/19/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import CoreLocation
import MessageUI

var mealCart : [Meal] = []

class ChefMealViewController: UIViewController, ZCarouselDelegate, MFMessageComposeViewControllerDelegate  {

    @IBOutlet weak var carouselMeals: ZCarousel!
    @IBOutlet weak var nameOfChef: UILabel!
    @IBOutlet weak var allergyInformation: UILabel!
    @IBOutlet weak var ownerProfilePicture: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var quantityAmountLabel: UILabel!
    @IBOutlet weak var addMealToCartButton: UIButton!
    @IBOutlet weak var decreaseQuantityButton: UIButton!
    @IBOutlet weak var increaseQuanityButton: UIButton!
    
    var userSnapshot : QueryDocumentSnapshot!
    var db: Firestore!
    let storage = Storage.storage()
    var mealsToDisplay : [Meal] = []
    var point : CLLocationCoordinate2D!
    var locationId : String!
    var userId : String!
    var mealImage : [UIImage] = []
    var meals: [Meal] = []
    var carouselIndex = 0
    var ordersToSend : [mealOrder] = []
    var selectedMealsIndex: [Int] = []
    var mealQuantities: [Int] = []
    var meals2 = false
    var phoneNumber = ""

    var quantity = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //tempLabel.text = viewDidShow
//        print(viewDidShow)
        print("1")
        db = Firestore.firestore()

        // Code That Gets the amount of rows necessary
        //let docRef = self.db.collection("locations").document(goatUser!
        setupData()
//        print(viewDidShow.data())
        let storageRef = self.storage.reference()
        let profileRef = storageRef.child("\(userId!).png")
        ownerProfilePicture.layer.cornerRadius = (ownerProfilePicture.bounds.size.height / 2)
        ownerProfilePicture.clipsToBounds = true
        
        // UIImageView in your ViewController
        profileRef.getData(maxSize: 2 * 2048 * 2048) { data, error in
            if let error = error {
                
                // Uh-oh, an error occurred!
                print(error.localizedDescription)
            }
            else {
                
                let image = UIImage(data: data!)
                self.ownerProfilePicture.image = image
                
            }
        }
        
        if let carouselMeals = carouselMeals {
            self.view.addSubview(carouselMeals)
        }
        carouselMeals?.ZCdelegate = self
        setupCarousel()
    }
    
    func ZCarouselShowingIndex(_ scrollView: ZCarousel, index: Int) {
        if scrollView == carouselMeals {
            

            self.allergyInformation.text = "Allergy Information:"
            print(index)
            var Allergies : [String] = []
            
            if meals2   {
                let index2 = index % 2
                mealName.text = (mealsToDisplay[index2].document.data()["mealName"] as! String)
                carouselIndex = index
                Allergies = (mealsToDisplay[index2].document["Allergies"] as? Array ?? [""])
                
            }
                
            else    {
            mealName.text = (mealsToDisplay[index].document.data()["mealName"] as! String)
            carouselIndex = index
            Allergies = (mealsToDisplay[index].document["Allergies"] as? Array ?? [""])
            }
            
            var buttonChanged = false
            
            for i in selectedMealsIndex  {
                if i == carouselIndex   {
                    changeButtonColorWhite()
                    buttonChanged = true
                }
            }
            
            if !buttonChanged   {
                changeButtonColorOrange()
                
                buttonChanged = true
            }
            
            for time in Allergies{
                let arr  = (self.allergyInformation.text ?? "")+String(time)+", " //+"<space>"+ to +","+ if you need lap times are comma separated.
                self.allergyInformation.text = arr
            }
            
            quantity = 1
            quantityAmountLabel.text = "\(quantity)"
            
            
        }
        else  {
            print("sike")
        }
    }
    
    func setupCarousel()   {
        
        let storageRef = self.storage.reference()
        self.db.collection("locations").document(userId).collection("meals").getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let group = DispatchGroup()
                
                
                
                for document in querySnapshot!.documents {
                    
                    
                    let meal = Meal()
                    meal.document = document
                    
                    group.enter()
                    let nameOfMeal = document.get("mealName") as! String
                    let mealImagesRef = storageRef.child("mealImages/\(self.userId!)/\(nameOfMeal)/0.png")
                    mealImagesRef.getData(maxSize: 2 * 2048 * 2048, completion: { (data, error) in
                        group.leave()
                        if let error = error {
                            // Uh-oh, an error occurred!
                            print("This is the error: \(error.localizedDescription)")
                        }
                        else {
                            // Data for "images/island.jpg" is returned
                            let image = UIImage(data: data!)
                            self.mealImage.append(image!)
                            meal.image = image
                            self.meals.append(meal)
                            
                            print("image set")
                        }
                    })
                }

                group.notify(queue: DispatchQueue.main) {
                    // All requests finished
                    if self.mealImage.count == 2 {
                        self.mealImage.append(self.mealImage[0])
                        self.mealImage.append(self.mealImage[1])
                        self.meals2 = true
                    }
                    self.mealsToDisplay = self.meals
                    print("big ned : \(self.mealImage)")
                    self.carouselMeals?.addImages(self.mealImage)
                    var startingIndex = self.mealsToDisplay.count / 2
                    if self.meals2   {
                        startingIndex -= 1
                    }
                    
                    if self.mealsToDisplay.count != 0    {
                    self.mealName.text = (self.mealsToDisplay[startingIndex].document.data()["mealName"] as! String)
                    let Allergies = (self.mealsToDisplay[startingIndex].document["Allergies"] as? Array ?? [""])
                    self.carouselIndex = startingIndex
                        for time in Allergies{
                            let arr  = (self.allergyInformation.text ?? "")+String(time)+", " //+"<space>"+ to +","+ if you need lap times are comma separated.
                            self.allergyInformation.text = arr
                        }
                    }
                }
            }
        })
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
    
    @IBAction func checkoutButton(_ sender: Any) {
        
        /*
        if meals2   {
            for num in selectedMealsIndex   {
                if num <= 1 {
                    let mealOrders = mealOrder()
                    mealOrders.meal = meals[num]
                    mealOrders.quantity = mealQuantities[num]
                    ordersToSend.append(mealOrders)
                }
            }
        }
        else    {
            for num in selectedMealsIndex   {
                let mealOrders = mealOrder()
                mealOrders.meal = meals[num]
                mealOrders.quantity = mealQuantities[num]
                ordersToSend.append(mealOrders)
            }
        }
        
        performSegue(withIdentifier: "checkoutSegue", sender: self)
        */
    }
    
    func changeButtonColorGray (button : UIButton)    {
        
            button.tintColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
            button.isUserInteractionEnabled = false
        
    }
    
    func changeButtonColorOrange (button : UIButton)    {
        
        button.tintColor =  UIColor(red: 20/255, green: 126/255, blue: 251/155, alpha: 1)
        button.isUserInteractionEnabled = true
        
    }
    
    @IBAction func addtoCartButton(_ sender: Any)   {
        print(mealQuantities)
        /*if UIApplication.shared.canOpenURL(URL(string:"sms:\(phoneNumber)&body=Tiffin:")!) {
            UIApplication.shared.open(URL(string:"sms:\(phoneNumber)&body=Tiffin:")!, options: [:], completionHandler: nil)
        }*//*
            let messageVC = MFMessageComposeViewController()
        
            messageVC.body = "Enter a message";
            messageVC.recipients = [phoneNumber]
            messageVC.messageComposeDelegate = self
            
            self.present(messageVC, animated: true, completion: nil)
        print("yessah")*/
        var currentlySelected = false
        print(mealQuantities)
        for index in selectedMealsIndex {
            if index == carouselIndex   {
                currentlySelected = true
            }
        }
        if !currentlySelected    {
            changeButtonColorGray(button: decreaseQuantityButton)
            changeButtonColorGray(button: increaseQuanityButton)
        if self.meals2   {
            
            if carouselIndex >= 2   {
                
            selectedMealsIndex.append(carouselIndex - 2)
            selectedMealsIndex.append(carouselIndex)
            mealQuantities.append(quantity)
            mealQuantities.append(quantity)
            }
            else    {
            selectedMealsIndex.append(carouselIndex + 2)
            selectedMealsIndex.append(carouselIndex)
            mealQuantities.append(quantity)
            mealQuantities.append(quantity)
            }
        }
        else    {
        selectedMealsIndex.append(carouselIndex)
        mealQuantities.append(quantity)
        }
        
        for index in selectedMealsIndex  {
            if index == carouselIndex   {
                changeButtonColorWhite()
            }
        }
        }
        else    {
            changeButtonColorOrange(button: decreaseQuantityButton)
            changeButtonColorOrange(button: increaseQuanityButton)
            changeButtonColorOrange()
            if meals2   {
                if carouselIndex >= 2   {
                    if let index = selectedMealsIndex.firstIndex(of: carouselIndex) {
                        mealQuantities.remove(at: index)
                        print("Remove Attempted")
                    }
                    if let index = selectedMealsIndex.firstIndex(of: carouselIndex - 2) {
                        mealQuantities.remove(at: index)
                        print("Remove Attempted")
                    }
                    selectedMealsIndex = selectedMealsIndex.filter { $0 != carouselIndex }
                    selectedMealsIndex = selectedMealsIndex.filter { $0 != carouselIndex - 2 }

                }
                else    {
                    if let index = selectedMealsIndex.firstIndex(of: carouselIndex) {
                        mealQuantities.remove(at: index)
                        print("Remove Attempted")
                    }
                    if let index = selectedMealsIndex.firstIndex(of: carouselIndex + 2) {
                        mealQuantities.remove(at: index)
                        print("Remove Attempted")
                    selectedMealsIndex = selectedMealsIndex.filter { $0 != carouselIndex }
                    selectedMealsIndex = selectedMealsIndex.filter { $0 != carouselIndex + 2 }
                    
                    }
                }
            }
            else    {
                selectedMealsIndex = selectedMealsIndex.filter { $0 != carouselIndex }
                if let index = selectedMealsIndex.firstIndex(of: carouselIndex) {
                    mealQuantities.remove(at: index)
                }
            }
        }
       // print(mealOrders.meal.document.data()["mealName"] as! String)
        //print(ordersToSend[0].meal.document.data()["mealName"] as! String)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    func changeButtonColorWhite() {
        
        addMealToCartButton.backgroundColor = UIColor(named: "white")
        addMealToCartButton.setTitleColor(UIColor.orange, for: .normal)
        addMealToCartButton.setTitle("Meal Added", for: .normal)
        print(selectedMealsIndex)
        
    }
    
    func changeButtonColorOrange()  {
        addMealToCartButton.backgroundColor = UIColor(red: 255/255, green: 86/255, blue: 0, alpha: 1)
        addMealToCartButton.setTitleColor(UIColor.white, for: .normal)
        addMealToCartButton.setTitle("Add Meal", for: .normal)
        print(selectedMealsIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkoutSegue"    {
            let destination: CheckoutViewController = segue.destination as! CheckoutViewController
            // destination.currentEmail2 = currentEmail
            destination.mealsInCart = ordersToSend
            destination.checkoutUserSnapshot = userSnapshot
        }
    }
    
    func setupData() {
        phoneNumber = (userSnapshot.data()["phoneNumberString"]! as? String)!
        var dictionaryOfData = userSnapshot.data()
        print(dictionaryOfData)
        
        let location = dictionaryOfData["location"] as! GeoPoint
        point = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        userId = userSnapshot.data()["owner"]! as? String
        locationId = userSnapshot.data()["name"]! as? String
        nameOfChef.text = locationId
        addMealToCartButton.setTitle(phoneNumber, for: .normal)
        
        
    }

    
    @IBAction func quantityIncreaseButton(_ sender: Any) {
        quantity += 1
        quantityAmountLabel.text = "\(quantity)"
    }
    @IBAction func quantityDecreaseButton(_ sender: Any) {
        if quantity != 0    {
            quantity -= 1
            quantityAmountLabel.text = "\(quantity)"
        }
    }
    
    var mealIndex = -1
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mealInformation"    {
            
            let destination: SpecificMealViewController = segue.destination as! SpecificMealViewController
            destination.mealLocation = point
            destination.mealName = locationId
            destination.mealChosen = mealsToDisplay[mealIndex]
            destination.mealOwnerId = userId
            destination.mealNumber = mealIndex
        }
    }*/

}

class Meal {
    var document: QueryDocumentSnapshot!
    var image: UIImage!
    var location: CLLocationCoordinate2D!
}
class mealOrder {
    
    var meal: Meal!
    var quantity: Int!
    
}
