//
//  UserStore.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/1.
//

import Foundation
import Combine

//class UserStore: ObservableObject{
//    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged"){
//        didSet{
//            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
//        }
//    }
//    @Published var showLogin: Bool
//    
//    init(){
//        self.showLogin = false
//    }
//    
//}


class UserDataStore: ObservableObject{
    @Published var userDataList: [UserData]
    var index: Int = 0
    init(){
        self.userDataList = []
        Api().getData{ (userdata) in
            self.userDataList = userdata
        }
    }
    
    init(userDataList: [UserData]){
        self.userDataList = []
        for item in userDataList{
            self.userDataList.append(UserData(id: self.index, username: item.username, avatar: item.avatar))
            index += 1
        }
    }
    
    func add(userData: UserData){
        self.userDataList.append(userData)
        self.index += 1
    }
}

struct UserData: Identifiable, Decodable, Equatable{
    var id: Int = 0
    var username: String
//    var password: String
    var avatar: String
    var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged"){
        didSet{
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    var showLogin: Bool = false
}

