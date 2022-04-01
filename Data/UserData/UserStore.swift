//
//  UserStore.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/1.
//

import Foundation
import Combine

class UserStore: ObservableObject{
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged"){
        didSet{
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin: Bool
    
    init(){
        self.showLogin = false
    }
    
}

struct UserData: Identifiable{
    var id: Int
    var username: String
    var password: String
    var headPicture: String
    
}
