//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    @IBAction func loginPressed(_ sender: UIButton) {
        // When user typed email and password, log in.
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [unowned self] authResult, error in
                if let e = error {
                    // Pop up error message.
                    self.popUpErrorMessage(error: e)
                } else {
                    // Navigate to the ChatViewController.
                    self.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
            }
        }
    }
    
    func popUpErrorMessage(error: Error) {
        let alert = UIAlertController(title: "Unable to log-in", message: error.localizedDescription, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(actionOk)
        present(alert, animated: true) {
            self.emailTextfield.text = ""
            self.passwordTextfield.text = ""
        }
    }
}
