//
//  UserStore.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/1.
//

import Foundation
import Combine

class UserStore: ObservableObject{
    @Published var isLogged: Bool
    @Published var showLogin: Bool
     
    init(){
        self.isLogged = false
        self.showLogin = false
    }
}
