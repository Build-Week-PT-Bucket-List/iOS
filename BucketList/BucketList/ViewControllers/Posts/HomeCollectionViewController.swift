//
//  HomeCollectionViewController.swift
//  BucketList
//
//  Created by Lambda_School_Loaner_188 on 10/22/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController {
    
    //Properties
    
    let userController = UserController()
    let itemController = ItemController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         performSegue(withIdentifier: "toLanding", sender: nil)
     }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemController.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as? PostCollectionViewCell else { return UICollectionViewCell() }
    
        let item = itemController.items[indexPath.item]
        cell.titleCategoryLabel.text = item.description
    
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLanding" {
            guard let landingVC = segue.destination as?
            LandingNavViewController else {return}
            landingVC.userController = userController
        } else if segue.identifier == "PopToAddItem" {
            guard let addItemVC = segue.destination as? CategoryAddPopViewController else { return }
            addItemVC.itemController = itemController
            addItemVC.userController = userController
        }
    }

    // MARK: UICollectionViewDelegate
}
