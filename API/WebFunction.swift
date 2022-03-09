//
//  WebFunction.swift
//  wang.dov
//
//  Created by i564206 on 2022/3/9.
//

import Foundation
import SwiftUI


class Api{
    
    
    func validateUsername(_ username: String?) throws{
        guard let username = username else{
            throw ValidationError.invalidValue
        }
        guard username.count > 3 else{ throw
            ValidationError.usernameTooShort
        }
        guard username.count < 20 else{
            throw ValidationError.usernameTooLong
        }
    }

    func validatePassword(_ password: String?) throws{
        guard let password = password else{
            throw ValidationError.invalidValue
        }
        guard password.count > 8 else{ throw
            ValidationError.passwordTooShort
        }
        guard password.count < 20 else{
            throw ValidationError.passwordTooLong
        }
    }
    
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
    func register(userName: String, password: String, completion: @escaping (Result<Any, Error>?) -> Void) throws -> Bool{
        try validateUsername(userName)
        try validatePassword(password)
        guard let url = URL(string: "http://192.168.01/users/register") else{ return false }
        
        let task = URLSession.shared.dataTask(with: url) { data, res, error in
            var statusCode = res?.toHttpUrlResponse()?.statusCode
            if statusCode == 301{
                completion(Result{
                    throw RegisterError.unKnownRegisterError
                    
                })
            }else if statusCode == 401{
                completion(Result{
                    throw RegisterError.userNameDuplicated
                })
            }
        }
        task.resume()
        return true
    }
    
    func confirm(userName: String, password: String, completion: @escaping (Result<Any, Error>?) -> Void) throws -> Bool{
        guard let url = URL(string: "http://192.168.0.1/users/login") else{ return false }

        let task = URLSession.shared.dataTask(with: url) { data, res, error in
            var statusCode = res?.toHttpUrlResponse()?.statusCode
            if statusCode == 404{
                completion(Result{
                    throw LoginError.userNotFound
                })
            }else if statusCode == 403{
                completion(Result{
                    throw LoginError.passwordWrong
                })
            }
        }
        task.resume()
        return true
    }
    
   
}


enum ValidationError: LocalizedError{
    case invalidValue
    case passwordTooLong
    case passwordTooShort
    case usernameTooLong
    case usernameTooShort

    var errorDescription: String?{
        switch self {
        case .invalidValue:
            return "invalid value"
        case .passwordTooLong:
            return "pwd too long"
        case .passwordTooShort:
            return "pwd too short"
        case .usernameTooLong:
            return "unm too long"
        case .usernameTooShort:
            return "unm too short"
        }
    }
}

enum LoginError: Error{
    case userNotFound
    case passwordWrong
    
    var  errorDescription: String?{
        switch self{
        case .passwordWrong:
            return "Your password not right"
        case .userNotFound:
            return "User not registered"
        }
    }
}

enum RegisterError: Error{
    case userNameDuplicated
    case unKnownRegisterError
    
    var errorDescription: String?{
        switch self{
        case .unKnownRegisterError:
            return "unknown error"
        case .userNameDuplicated:
            return "User had been registered"
        }
    }
}
