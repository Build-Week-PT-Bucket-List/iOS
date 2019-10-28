//
//  LandingNavViewController.swift
//  BucketList
//
//  Created by Stephanie Bowles on 10/21/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class LandingNavViewController: UINavigationController {

    
    var userController: UserController?
    override func viewDidLoad() {
        super.viewDidLoad()

         let landingPageVC = viewControllers.first as? LandingPageViewController
               landingPageVC?.userController = userController
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
