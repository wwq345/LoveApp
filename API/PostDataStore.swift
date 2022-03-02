//
//  PostDataStore.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/22.
//

import Foundation
import Combine

class PostDataStore: ObservableObject{
    @Published var posts: [Post]
    
    init(){
        self.posts = []
        self.getPosts()
    }
    
    func getPosts(){
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
