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
    
    //    func signUp(with user: User, completion: @escaping (Error?) -> ()) {
    func signUp(name: String, email: String, password: String, completion: @escaping (Error?) -> Void = {_ in}) {
        let signUpURL = baseURL.appendingPathComponent("/register")
        
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
        //        let jsonEnconder = JSONEncoder()
        //               do {
        //                   let jsonData = try jsonEnconder.encode(user)
        //                   request.httpBody = jsonData
        //               } catch {
        //                   print("Error encoding user object: \(error)")
        //                   completion(error)
        //                   return
        //               }
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
            NSLog("Successfully signed up User")
            
//            completion(nil)
        } .resume()
    }
    
//    func logIn(with user: User, completion: @escaping (NetworkError?) -> ()) {
    
    func logIn(email: String, password: String, completion: @escaping (NetworkError?) -> Void) {
        //            guard let bearer = self.bearer else {
        //                completion(.noAuth)
        //                              return
        //                          }
        let logInURL = baseURL.appendingPathComponent("login")
        var request = URLRequest(url: logInURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //            request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        let userParams = ["email": email, "password": password] as [String: Any]
        do {
            let json = try JSONSerialization.data(withJSONObject: userParams, options: .prettyPrinted)
            request.httpBody = json
        } catch {
            NSLog("Error encoding JSON")
        }
        
//        let jsonEncoder = JSONEncoder()
//        do {
//            let jsonData = try jsonEncoder.encode(user)
//            request.httpBody = jsonData
//        } catch {
//            NSLog("Error encoding user object: \(error)")
//            completion(.noAuth)
//        }
//
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
            
//            do {
//                self.bearer = try decoder.decode(Bearer.self, from: data)
//
//            } catch {
//                NSLog("error decoding bearer object: \(error)")
//                completion(.noDecode)
//                return
//
//            }
            
            do {
                let jwtToken = try decoder.decode(JWT.self, from: data)
                let jwt = try decode(jwt: jwtToken.jwt)
                let id = jwt.body["id"] as! Int
                self.bearer = jwt.string
            } catch {
                NSLog("Error decoding JSON Web token" )
                return
            }
            NSLog("successfully logged in user")
            completion(nil)
        
        } .resume()
        
    }
    
    
//    func saveUser(id: Int, token: String, created: "string" ) {
//        guard let bearer = bearer else {return }
//        UserDefaults.standard.set("\(bearer.token)", forKey: "Bearer")
//        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.id.rawValue)
//        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
//        UserDefaults.standard.set(created, forKey: UserDefaultsKeys.created.rawValue)
//    }  // ask about this
}


