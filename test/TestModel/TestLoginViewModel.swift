//
//  LoginViewModel.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/11.
//

import Foundation

class TestLoginViewModel: ObservableObject{
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenicationError?
    
    
    var loginDisabled: Bool{
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void){
        showProgressView = true
        ApiService.shaerd.login(credentials: credentials) {[unowned self](result: Result<Bool, Authentication.AuthenicationError>) in
            showProgressView = false
            switch result{
            case .success:
                completion(true)
            case .failure(let authError):
                credentials = Credentials()
                error = authError
                completion(false)
            }
        }
    }
}
