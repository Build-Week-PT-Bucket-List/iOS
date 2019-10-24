//
//  UserController.swift
//  BucketList
//
//  Created by Stephanie Bowles on 10/18/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation
import UIKit
import JWTDecode

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
    
    
    func signUp(name: String, email: String, password: String, completion: @escaping (Error?) -> Void = {_ in}) {
        let signUpURL = baseURL.appendingPathComponent("register")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.addValue("USER_TOKEN", forHTTPHeaderField: "Authorization")
        
        let userParams = ["name": name, "email": email, "password": password] as [String: Any]
        do {
            let json = try JSONSerialization.data(withJSONObject: userParams, options: .prettyPrinted)
            request.httpBody = json
        } catch {
            NSLog("Error encoding JSON")
            return
        }
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                
                completion(NSError(domain:"", code: response.statusCode, userInfo: nil))
                return
            }
            if let error = error {
                completion(error)
                return
            }
//            guard let data = data else {
//                completion(error)
//                return
//            }
            NSLog("Successfully signed up User")
            self.logIn(email: email, password: password, completion: completion)
 
            completion(nil)
        } .resume()
    }
    
    func logIn(email: String, password: String, completion: @escaping (NetworkError?) -> Void) {

        let logInURL = baseURL.appendingPathComponent("login")
        var request = URLRequest(url: logInURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        let userParams = ["email": email, "password": password] as [String: Any]
        do {
            let json = try JSONSerialization.data(withJSONObject: userParams, options: .prettyPrinted)
            request.httpBody = json
        } catch {
            NSLog("Error encoding JSON")
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
            do {

                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
//                let jwt = try decode(jwt: bearer.token)
                 let _ = try decode(jwt: bearer.token)
//                let id = jwt.body["id"] as! Int
                self.bearer = bearer
            } catch {
                NSLog("Error decoding JSON Web token" )
                return
            }
            NSLog("successfully logged in user")
            completion(nil)
            
        } .resume()
        
    }
    
    func getUser(user: User?, completion: @escaping ( NetworkError?) -> Void) {
        let userURL = baseURL.appendingPathComponent("user")
        
        
        var request = URLRequest(url: userURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        guard let bearer = self.bearer else {
            completion(.noAuth)
            return
        }
//        guard let token = UserDefaults.standard.token else {
//            NSLog("No JWT Token Set to User Defaults")
//            return
//        }
        
        request.setValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error getting user: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error retrieving data from server")
                return
            }
            
            if let response = response as? HTTPURLResponse,
                          response.statusCode != 200 {
                          
                          completion(.badAuth)
                          return
                      }
            
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                self.user = user
                completion( nil)
            } catch {
                NSLog("Error with network request: \(error)")
                return
            }
            
            NSLog("Successfully fetched User")
            
            
        }.resume()
        
    }
    //    func saveUser(id: Int, token: String, created: "string" ) {
    //        guard let bearer = bearer else {return }
    //        UserDefaults.standard.set("\(bearer.token)", forKey: "Bearer")
    //        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.id.rawValue)
    //        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    //        UserDefaults.standard.set(created, forKey: UserDefaultsKeys.created.rawValue)
    //    }  // ask about this
}


