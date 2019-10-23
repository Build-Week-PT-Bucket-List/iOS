//
//  Posts.swift
//  BucketList
//
//  Created by Lambda_School_Loaner_188 on 10/22/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation

struct Post {
    var posts: Posts
}

struct Posts: Codable {
        var id: Int?
        var message: String?
        var created: String?
        
        init(id: Int?, message: String?, created: String?) {
              self.id = id
              self.message = message
              self.created = created
        
    }
        
        
}

struct Image: Codable {
    var id: Int?
//    var post_id: Int
    var url: URL
    var created: String
    
    init(id: Int?, url: URL, created: String) {
        self.id = id
        self.url = url
        self.created = created
    }
    
}


