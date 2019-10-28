//
//  CategoryAddPopViewController.swift
//  BucketList
//
//  Created by Lambda_School_Loaner_188 on 10/22/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class CategoryAddPopViewController: UIViewController {

    //Outlets
    
    @IBOutlet weak var popImageView: UIImageView!
    @IBOutlet weak var popNameTextField: UITextField!
    @IBOutlet weak var popView: UIView!
    
    var userController: UserController?
    var itemController: ItemController?
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
    }
    
    // MARK: - Navigation

    // Image add to pop
    @IBAction func addImageButton(_ sender: Any) {
    }
    
    @IBAction func popSaveTapped(_ sender: Any) {
        if let itemTitle = popNameTextField.text, !itemTitle.isEmpty {
            itemController?.create(user_id: 33, description: itemTitle, completed: false)
        }
        for item in itemController!.items {
            NSLog("Array: \(String(describing: item.description))\n")
        }
        dismiss(animated: true, completion: nil)
    }
}
