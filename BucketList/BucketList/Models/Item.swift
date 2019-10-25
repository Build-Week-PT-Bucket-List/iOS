//
//  Item.swift
//  BucketList
//
//  Created by Jessie Ann Griffin on 10/22/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation

struct ItemId: Codable {
    var id: Int
}

struct Item: Codable {
    var id: ItemId?
    var user_id: Int
    var description: String?
    var completed: Bool?
//    var posts: [Post]
    
    
    init(user_id: Int, description: String?, completed: Bool? = false) {
        self.user_id = user_id
        self.description = description
        self.completed = completed
    }
}
