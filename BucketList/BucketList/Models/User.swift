//
//  User.swift
//  BucketList
//
//  Created by Stephanie Bowles on 10/18/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation



struct UserResponse {
    var user: User
    
    struct User: Codable {
        var id: Int?
        var name: String
        var email: String
        var password: String
        var created: String?
        
        init(id: Int?, name: String, email: String, password: String, created: String?) {
              self.id = id
              self.name = name
              self.email = email
              self.password = password
              self.created = created 
          }
    }
}
 
