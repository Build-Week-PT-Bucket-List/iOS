//
//  LogInViewController.swift
//  BucketList
//
//  Created by Stephanie Bowles on 10/18/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var userController: UserController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
         guard let userController = self.userController else {return}
                
                if let email = self.emailTextField.text,
                    !email.isEmpty,
                    let password = self.passwordTextField.text, !password.isEmpty {
                    let user = User(id: nil, name: nil, email: email, password: password, created: nil)
                    
                    userController.logIn(with: user) { (error) in
                        if let error = error {
                            NSLog("Error occured during log in: \(error)")
                        } else {
                            DispatchQueue.main.async {
     
                                self.dismiss(animated: true, completion: nil)
       
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
