//
//  Movie.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/2/27.
//

import Foundation

struct Movie: Equatable{
    let title: String
    let releaseDate: String?
    
    init(){
        self.title = " "
        self.releaseDate = " "
    }
    
    init(title: String, releaseDate: String? = nil){
        self.title = title
        self.releaseDate = releaseDate
    }
}
