//
//  AllergyViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 6/14/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit



class AllergyViewController: UIViewController {

    @IBOutlet weak var peanutAllergy: UIButton!
    
    @IBOutlet weak var milkAllergy: UIButton!
    @IBOutlet weak var soyAllergy: UIButton!
    @IBOutlet weak var eggAllergy: UIButton!
    @IBOutlet weak var shellfishAllergy: UIButton!
    @IBOutlet weak var treeNutAllergy: UIButton!
    @IBOutlet weak var fishAllergy: UIButton!
    @IBOutlet weak var wheatAllergy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wheatAllergy.clipsToBounds = true
        wheatAllergy.layer.cornerRadius = 65
        wheatAllergy.layer.borderWidth = 5
        wheatAllergy.layer.borderColor = UIColor.init(displayP3Red: 232.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1.0).cgColor
        fishAllergy.clipsToBounds = true
        fishAllergy.layer.cornerRadius = 65
        fishAllergy.layer.borderWidth = 5
        fishAllergy.layer.borderColor = UIColor.init(displayP3Red: 232.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1.0).cgColor
        treeNutAllergy.clipsToBounds = true
        treeNutAllergy.layer.cornerRadius = 65
        treeNutAllergy.layer.borderWidth = 5
        treeNutAllergy.layer.borderColor = UIColor.init(displayP3Red: 232.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1.0).cgColor
        shellfishAllergy.clipsToBounds = true
        shellfishAllergy.layer.cornerRadius = 65
        shellfishAllergy.layer.borderWidth = 5
        shellfishAllergy.layer.borderColor = UIColor.init(displayP3Red: 232.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1.0).cgColor
        eggAllergy.clipsToBounds = true
        eggAllergy.layer.cornerRadius = 65
        eggAllergy.layer.borderWidth = 5
        eggAllergy.layer.borderColor = UIColor.init(displayP3Red: 232.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1.0).cgColor
        soyAllergy.clipsToBounds = true
        soyAllergy.layer.cornerRadius = 65
        soyAllergy.layer.borderWidth = 5
        soyAllergy.layer.borderColor = UIColor.init(displayP3Red: 232.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1.0).cgColor
        peanutAllergy.clipsToBounds = true
        peanutAllergy.layer.cornerRadius = 65
        peanutAllergy.layer.borderWidth = 5
        peanutAllergy.layer.borderColor = UIColor.init(displayP3Red: 232.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1.0).cgColor
        milkAllergy.clipsToBounds = true
        milkAllergy.layer.cornerRadius = 65
        milkAllergy.layer.borderWidth = 5
        milkAllergy.layer.borderColor = UIColor.init(displayP3Red: 232.0/255, green: 142.0/255, blue: 53.0/255, alpha: 1.0).cgColor
        // Do any additional setup after loading the view.
    }
    
    var ref: DocumentReference? = nil
    ref = db.collection("users").addDocument(data: [
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
    ]) { err in
    if let err = err {
    print("Error adding document: \(err)")
    } else {
    print("Document added with ID: \(ref!.documentID)")
    }
    }
    
    @IBAction func allergyButtonClicked(_ sender: Any) {
        
        if self.peanutAllergy.alpha == 1.0  {
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.peanutAllergy.alpha = 0.3
            
        }, completion: nil)
        }
        else    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.peanutAllergy.alpha = 1.0
                
            }, completion: nil)
            
        }
    }
    @IBAction func milkButtonClick(_ sender: Any) {
        if self.milkAllergy.alpha == 1.0    {
            
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.milkAllergy.alpha = 0.3
            
        }, completion: nil)
            
        }
        else    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.milkAllergy.alpha = 1.0
                
            }, completion: nil)
            
        }
    }
    
    // Actually for Soy Allergy
    @IBAction func peanutAllergyClick(_ sender: Any) {
        
        if self.soyAllergy.alpha == 1.0    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.soyAllergy.alpha = 0.3
                
            }, completion: nil)
            
        }
        else    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.soyAllergy.alpha = 1.0
                
            }, completion: nil)
            
        }
        
    }
    
    @IBAction func soyAllergy(_ sender: Any) {
    }
    
    @IBAction func eggAllergyClicked(_ sender: Any) {
        
        if self.eggAllergy.alpha == 1.0    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.eggAllergy.alpha = 0.3
                
            }, completion: nil)
            
        }
        else    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.eggAllergy.alpha = 1.0
                
            }, completion: nil)
            
        }
        
    }
    
    @IBAction func shellfishAllergyClicked(_ sender: Any) {
        
        if self.shellfishAllergy.alpha == 1.0    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.shellfishAllergy.alpha = 0.3
                
            }, completion: nil)
            
        }
        else    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.shellfishAllergy.alpha = 1.0
                
            }, completion: nil)
            
        }
        
    }
    
    @IBAction func treeNutAllergyClicked(_ sender: Any) {
        
        if self.treeNutAllergy.alpha == 1.0    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.treeNutAllergy.alpha = 0.3
                
            }, completion: nil)
            
        }
        else    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.treeNutAllergy.alpha = 1.0
                
            }, completion: nil)
            
        }
        
    }
    
    @IBAction func fishAllergy(_ sender: Any) {
        
        if self.fishAllergy.alpha == 1.0    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.fishAllergy.alpha = 0.3
                
            }, completion: nil)
            
        }
        else    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.fishAllergy.alpha = 1.0
                
            }, completion: nil)
            
        }
        
    }
    
    @IBAction func wheatAllergy(_ sender: Any) {
        
        if self.wheatAllergy.alpha == 1.0    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.wheatAllergy.alpha = 0.3
                
            }, completion: nil)
            
        }
        else    {
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.wheatAllergy.alpha = 1.0
                
            }, completion: nil)
            
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
