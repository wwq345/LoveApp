//
//  ApiService.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/11.
//

import Foundation

class ApiService {
    static let shaerd = ApiService()
    
    
    func login(credentials: Credentials, completion: @escaping (Result<Bool, Authentication.AuthenicationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if credentials.password == "password"{
                completion(.success(true))
            }else{
                completion(.failure(Authentication.AuthenicationError.invalidCredentials))
            }
        }
    }
}
