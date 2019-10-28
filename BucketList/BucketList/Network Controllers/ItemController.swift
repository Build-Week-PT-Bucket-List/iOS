//
//  ItemController.swift
//  BucketList
//
//  Created by Jessie Ann Griffin on 10/22/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation
import UIKit
import JWTDecode


class ItemController {
    var item: Item?
    var items: [Item] = []
    var bearer: Bearer?
//    var itemId: ItemId?
    // bearer is coming from userController - how can I pass the bearer from the userController to the itemController
    var userController: UserController?
    
    private let baseURL = URL(string: "https://bw-pt-bucket-list.herokuapp.com/api")!
    
    func fetchItems() { // GET
        
    }
    
    func create(user_id: Int, description: String?, completed: Bool?) {
        let item = Item(user_id: user_id, description: description, completed: completed)
        items.append(item)
        postItem(item: item) { (error) in
            if let error = error {
                NSLog("Error occured during POST: \(error)")
                return
            }
        }
//        NSLog("Item id is: \(item.id!)")

        NSLog("Created item with description \(item.description!)")
    }
    
    func postItem(item: Item, completion: @escaping (NetworkError?) -> Void) { // PUT
        let createURL = baseURL.appendingPathComponent("item")
        guard let bearer = userController?.bearer else { return }
        self.bearer = bearer
        
        var request = URLRequest(url: createURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        do {
            let jsonData = try JSONEncoder().encode(item)
            request.httpBody = jsonData
         } catch {
            NSLog("Error encoding item object to api: \(error)")
            completion(.otherError)
            return
         }
         
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.badAuth)
                return
            }
            
            if let error = error {
                NSLog("Error POSTing item to server: \(error)")
                completion(.otherError)
                return
             }
            
            guard let data = data else {
                completion(.badData)
                return
            }
            
            do {
                let itemId = try JSONDecoder().decode(ItemId.self, from: data)
                let _ = try decode(jwt: "\(itemId.id)")
                self.item?.id = itemId
            } catch {
                NSLog("Error decoding item id")
                completion(.noDecode)
                return
            }
            completion(nil)
            
        } .resume()
    }
    
    func fetchSingleItem(item: Item, completion: @escaping (NetworkError?) -> Void) { // GET
        
        guard let bearer = userController?.bearer else {
            completion(.noAuth)
            return
        }
        self.bearer = bearer
        
        guard let id = item.id else {
        print("Trip Id failed")
        completion(.otherError)
        return}
      
        let getURL = baseURL.appendingPathComponent("item/:\(id)")
        
          
        var request = URLRequest(url: getURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.badAuth)
                return
            }
            if let error = error {
                NSLog("Error getting item \(error)")
                completion(.otherError)
                return
            }
            guard let data = data else {
                NSLog("No data returned" )
                completion(.badData)
                return
            }
            
            do {
                let decodedItem = try JSONDecoder().decode(Item.self, from: data)
                guard let itemIndex = self.items.firstIndex(of: item) else {throw NetworkError.otherError}
                self.items[itemIndex] = decodedItem
                completion(nil)
            } catch {
                NSLog("Error decoding item: \(error)")
                completion(.noDecode)
                return
            }
        } .resume()
        
//        let fetchItemURL = baseURL.appendingPathComponent("item/\(id)")

//        GET /api/item/:item_id
//        -header:
//            -Authorization : USER_TOKEN -Required
//        -returns bucket list item by id
//            *example:
//                {
//                  "item": {
//                    "id": 1,
//                    "user_id": 1,
//                    "completed": false,
//                    "description": "Drive a Ferrari",
//                    "created": "2019-06-28T15:52:58.870Z"
//                  }
//                }
    }
    
    func update() { // POST
        
    }
    
    func delete() { // DELETE
        
    }
}
