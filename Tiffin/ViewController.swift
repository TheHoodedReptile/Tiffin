//
//  ViewController.swift
//  Tiffin
//
//  Created by Shaurya Pathak on 6/13/19.
//  Copyright © 2019 GoatIndustries. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.cornerRadius = 20
        
    }

    
}

