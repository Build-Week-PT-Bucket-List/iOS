//
//  SignUpViewController.swift
//  BucketList
//
//  Created by Stephanie Bowles on 10/18/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var userController: UserController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let userController = self.userController else {return}
         
         if let name = self.nameTextField.text,
         !name.isEmpty,
            let email = self.emailTextField.text, !email.isEmpty,
             let password = self.passwordTextField.text, !password.isEmpty {
            let user = User(id: nil, name: name, email: email, password: password, created: nil)
             
            userController.signUp(with: user) { (error) in
                 if let error = error {
                     NSLog("Error occured during sign up: \(error)")
                 } else {
                     DispatchQueue.main.async {
                         let alertController = UIAlertController(title: "Sign Up Successful", message: "Now please log in", preferredStyle: .alert)
                         let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                             
                             self.performSegue(withIdentifier: "showLogIn", sender: nil)
                         })
                         
                         alertController.addAction(alertAction)
                         self.present(alertController, animated: true)
                 }
              }
           }
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
