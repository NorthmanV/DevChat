//
//  LoginVC.swift
//  DevChat
//
//  Created by Руслан Акберов on 24.12.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailField.text, let pass = passwordField.text, email.count > 0, pass.count > 0 {
            AuthService.instance.login(email: email, password: pass, onComplete: { (errorMessage, data) in
                guard errorMessage == nil else {
                    let alert = UIAlertController(title: "Authentication Error", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            let alert = UIAlertController(title: "Email and Password required", message: "You must enter both an email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}
