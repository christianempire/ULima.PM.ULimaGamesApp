//
//  HomeController.swift
//  ULimaGamesApp
//
//  Created by System Administrator on 5/14/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var NameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Begin(sender: AnyObject) {
        if NameTextField.text?.isEmpty ?? true {
            
        } else {
            performSegueWithIdentifier("ShowGamesSegue", sender: self)
        }
    }
}
