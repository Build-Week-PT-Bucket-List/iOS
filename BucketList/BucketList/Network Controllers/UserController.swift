//
//  UserController.swift
//  BucketList
//
//  Created by Stephanie Bowles on 10/18/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation
import UIKit

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
    
    var user: User?
    var bearer: Bearer?
    
    
    
    private let baseURL = URL(string: "https://bw-pt-bucket-list.herokuapp.com/api")!
    
    func signUp(with user: User, completion: @escaping (Error?) -> ()) {
        let signUpURL = baseURL.appendingPathComponent("/register")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("USER_TOKEN", forHTTPHeaderField: "Authorization")
        
        let jsonEnconder = JSONEncoder()
               do {
                   let jsonData = try jsonEnconder.encode(user)
                   request.httpBody = jsonData
               } catch {
                   print("Error encoding user object: \(error)")
                   completion(error)
                   return
               }
               URLSession.shared.dataTask(with: request) { data, response, error in
                   if let response = response as? HTTPURLResponse,
                       response.statusCode != 200 {
                     
                       completion(NSError(domain:"", code: response.statusCode, userInfo: nil))
                       return
                   }
                   if let error = error {
                       completion(error)
                       return
                   }
                    guard let data = data else {
                                    completion(error)
                                    return
                                }
                                let decoder = JSONDecoder()
                                
                                do {
                                    self.bearer = try decoder.decode(Bearer.self, from: data)
                                    
                                    
                                } catch {
                                    NSLog("error decoding bearer object: \(error)")
                                    completion(error)
                                    return
                                    
                                }
                   completion(nil)
                   } .resume()
    }
    
    func logIn(with user: User, completion: @escaping (NetworkError?) -> ()) {
//            guard let bearer = self.bearer else {
//                completion(.noAuth)
//                              return
//                          }
            let logInURL = baseURL.appendingPathComponent("login")
            var request = URLRequest(url: logInURL)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
           
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(user)
                request.httpBody = jsonData
            } catch {
                NSLog("Error encoding user object: \(error)")
                completion(.noAuth)
            }
            
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                  
                    completion(.badAuth)
                    return
                }
                if let _ = error {
                    completion(.otherError)
                    return
                }
                guard let data = data else {
                    completion(.badData)
                    return
                }
                let decoder = JSONDecoder()
                
                do {
                    self.bearer = try decoder.decode(Bearer.self, from: data)
   
                } catch {
                    NSLog("error decoding bearer object: \(error)")
                    completion(.noDecode)
                    return
                    
                }
                completion(nil)
                } .resume()
            
        }
}


