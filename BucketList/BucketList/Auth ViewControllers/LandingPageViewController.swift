//
//  LandingPageViewController.swift
//  BucketList
//
//  Created by Stephanie Bowles on 10/21/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {

    var userController: UserController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
    }
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignUp" {
                   if let signupVC = segue.destination as? SignUpViewController {
                       signupVC.userController = userController
                   }
               } else if segue.identifier == "toLogIn" {
                   guard let loginVC = segue.destination as? LogInViewController else {return}
                   loginVC.userController = userController
               }
    }
 

}
