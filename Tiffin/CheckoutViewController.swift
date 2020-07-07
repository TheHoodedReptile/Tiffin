//
//  CheckoutViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 1/19/20.
//  Copyright © 2020 GoatIndustries. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import CoreLocation

class checkoutCell : UITableViewCell  {
    
    @IBOutlet weak var headMealName: UILabel!
    @IBOutlet weak var subAmountText: UILabel!
    @IBOutlet weak var imageMeal: UIImageView!
    @IBOutlet weak var quantityNumber: UILabel!
    @IBOutlet weak var quantityIncrease: UIButton!
    @IBOutlet weak var quantityDecrease: UIButton!
    
}



class CheckoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource   {


    @IBOutlet weak var finalCheckoutTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.finalCheckoutTableView.dataSource = self
        self.finalCheckoutTableView.delegate = self
        print(mealsInCart[0].quantity!)
        
    }
    
    var mealsInCart : [mealOrder] = []
    var checkoutUserSnapshot : QueryDocumentSnapshot!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkoutCell", for: indexPath)
            as! checkoutCell
        let index = indexPath.row
        let cost = (mealsInCart[index].meal.document.data()["cost"] as! String)
        cell.headMealName.text = (mealsInCart[index].meal.document.data()["mealName"] as! String)
        cell.quantityNumber.text = "\(mealsInCart[index].quantity!)"
        cell.imageMeal.image = mealsInCart[index].meal.image
        cell.subAmountText.text = "$\(cost)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("detected")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backChefMealSegue"   {
            let destination: ChefMealViewController = segue.destination as! ChefMealViewController
            // destination.currentEmail2 = currentEmail
            destination.ordersToSend = mealsInCart
            destination.userSnapshot = checkoutUserSnapshot
        }
    }
    
    @IBAction func backButtonChefMealViewController(_ sender: Any) {
        
        performSegue(withIdentifier: "backChefMealSegue", sender: self)
        
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
