//
//  UserController.swift
//  BucketList
//
//  Created by Stephanie Bowles on 10/18/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation

 enum HTTPMethod: String {
     case get = "GET"
     case put = "PUT"
     case post = "POST"
     case delete = "DELETE"
 }

 enum NetworkError: Error {
     case noAuth
     case badAuth
     case otherError
     case badData
     case noDecode
 }

class UserController {
    var user: UserResponse.User?
    var bearer: Bearer?
}
