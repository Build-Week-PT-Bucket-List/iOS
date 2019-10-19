//
//  CategoryAddPopViewController.swift
//  BucketList
//
//  Created by Lambda_School_Loaner_188 on 10/18/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class CategoryAddPopViewController: UIViewController {

    //Outlets
    
    @IBOutlet weak var popImageView: UIImageView!
    @IBOutlet weak var popNameTextField: UITextField!
    @IBOutlet weak var popView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func popSaveTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
