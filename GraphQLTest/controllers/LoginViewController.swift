//
//  LoginViewController.swift
//  GraphQLTest
//
//  Created by Zeeshan Tufail on 14/12/19.
//  Copyright © 2019 Zeeshan Tufail. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let LOGIN_EMAIL : String = "fyp@vu.com"
    let LOGIN_PASSWORD : String = "fypstudent"
    
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    
    @IBOutlet weak var lblError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        lblError.isHidden = true
        // Do any additional setup after loading the view.
        self.isModalInPresentation = true
    }
    
    @IBAction func loginClick(_ sender: Any) {
        
        if ( textEmail.text!.isEmpty ){
            lblError.text = "You must enter you email"
            lblError.isHidden = false
            return
        }
        if ( textPassword.text!.isEmpty ){
            lblError.text = "You must enter you password"
            lblError.isHidden = false
            return
        }
        
        if ( textEmail.text!.elementsEqual(LOGIN_EMAIL) && textPassword.text!.elementsEqual(LOGIN_PASSWORD)) {
            self.dismiss(animated: true, completion: nil)
        } else {
            lblError.text = "Wrong email or password. Please try again"
        }
        
        
    }
    
}
