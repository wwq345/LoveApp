//
//  LoginViewModel.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/11.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var error: ErrorMayHave.LoginError?
    
    init(){
        self.error = nil
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void){
        Api().login(userName: username, password: password) { [unowned self](result: Result<Bool, ErrorMayHave.LoginError>) in
            switch result{
            case .success:
                completion(true)
            case .failure(let authError):
                error = authError
                completion(false)
            }
        }
    }
}
