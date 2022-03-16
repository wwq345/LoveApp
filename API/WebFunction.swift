//
//  WebFunction.swift
//  wang.dov
//
//  Created by i564206 on 2022/3/9.
//

import Foundation
import SwiftUI


class Api{
    
    static let shared = Api()
    
    func getData(completion: @escaping ([UserData]) -> ()){
        //guard let url = URL(string: "htp://192.168.0.0.1/users/getuser")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _)  in
            guard let data = data else {
                return
            }

            let userdata = try! JSONDecoder().decode([UserData].self, from: data)
            
            DispatchQueue.main.async {
                completion(userdata)
            }
        }
        .resume()
    }
    
    //emmmm, do you really know what're you writing?
    func register(userName: String, password: String, completion: @escaping (Result<Bool, ErrorMayHave.RegisterError>?) -> Void) {
//        try validateUsername(userName)
//        try validatePassword(password)
        guard let url = URL(string: "http://192.168.01/users/register") else{ return }
        
        let task = URLSession.shared.dataTask(with: url) { data, res, error in
            let statusCode = res?.toHttpUrlResponse()?.statusCode
            if statusCode == 301{
                completion(.failure(ErrorMayHave.RegisterError.userNameDuplicated))
            }else if statusCode == 401{
                completion(.failure(ErrorMayHave.RegisterError.unKnownRegisterError))
            }else if statusCode == 200{
                completion(.success(true))
            }
        }
        task.resume()
//        return true
    }
    
    //still wired function: It's should return an index that the userData in userDataList
    func login(userName: String, password: String, completion: @escaping (Result<Bool, ErrorMayHave.LoginError>) -> Void) {
        guard let url = URL(string: "http://192.168.0.1/users/login") else{ return }

        let task = URLSession.shared.dataTask(with: url) { data, res, error in
            let statusCode = res?.toHttpUrlResponse()?.statusCode
            if statusCode == 404{
                completion(.failure(ErrorMayHave.LoginError.userNotFound))
            }else if statusCode == 403{
                completion(.failure(ErrorMayHave.LoginError.passwordWrong))
            }else if statusCode == 200{
                completion(.success(true))
            }
        }
        task.resume()
//        return true
    }
    
    
    
}



