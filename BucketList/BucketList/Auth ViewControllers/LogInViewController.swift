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
        
        guard let email = self.emailTextField.text,
            !email.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty else {return}
        
        userController.logIn(email: email, password: password) { (error) in
            
            if let error = error {
                NSLog("Error occured during log in: \(error)")
                return
            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Log in successful", message: "Welcome to Bucket List", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                }
            }
            
        }
            
            //                    DispatchQueue.main.async {
            
            //                            self.dismiss(animated: true, completion: nil)
            //                        self.navigationController?.popViewController(animated: true)
            //                                self.navigationController?.popToViewController(LandingPageViewController, animated: true)
            
            
            
            
     
        
   
    }
    }
    extension UINavigationController {
        func popToViewController(ofClass: AnyClass, animated: Bool = true) {
            if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
                popToViewController(vc, animated: animated)
            }
        }
}
