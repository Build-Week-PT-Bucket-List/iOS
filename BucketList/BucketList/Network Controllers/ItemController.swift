//
//  ItemController.swift
//  BucketList
//
//  Created by Jessie Ann Griffin on 10/22/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation
import UIKit

class ItemController {
//    var item: Item?
//    static var quantity = 0
    
    private let baseURL = URL(string: "https://bw-pt-bucket-list.herokuapp.com/api")!
    
    func fetchItems() { // GET
        
    }
    
    func create(id: Int, description: String?, completed: Bool?) {
        let item = Item(user_id: id, description: description, completed: completed)
        put(item: item)
    }
    
    func put(item: Item, completion: @escaping (Error?) -> Void = { _ in }) { // PUT
        let createURL = baseURL.appendingPathComponent("item")
        
        var request = URLRequest(url: createURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("USER_TOKEN", forHTTPHeaderField: "Authorization")
        
        do {
            let jsonData = try JSONEncoder().encode(item)
            request.httpBody = jsonData
         } catch {
            NSLog("Error encoding item object to api: \(error)")
            completion(error)
            return
         }
         
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error POSTing item to server: \(error)")
                completion(error)
                return
             }
             completion(nil)
        } .resume()
    }
    
    func read() { // GET
        
    }
    
    func update() { // POST
        
    }
    
    func delete() { // DELETE
        
    }
}
