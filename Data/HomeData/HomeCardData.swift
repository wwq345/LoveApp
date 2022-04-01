//
//  HomeCardData.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/2.
//

import SwiftUI
import Combine


class HomeCardDataList: ObservableObject{
    @Published var cardList: [homeCardData]
    var count: Int = 0
    
    init(){
        self.cardList = [
            homeCardData(title: "How to Love", color: Color("Color1"),image: "cloud"),
            homeCardData(title: "who to Love", color: Color("Color2"),image: "mountain"),
            homeCardData(title: "when to Love", color: Color("Color3"),image: "sunset"),
            homeCardData(title: "where to Love", color: Color("Color4"),image: "grass"),
            homeCardData(title: "The day you meet", color: Color("Color8"), image: "sea")
        ]
    }
    
    init(cardDataList: [homeCardData]){
        self.cardList = []
        for item in cardDataList{
            self.cardList.append(homeCardData(id:self.count, title: item.title, color: item.color, image: item.image))
            self.count += 1
        }
        
    }
    
}

struct homeCardData: Identifiable{
    var id: Int = 0
    var title:String
    var text: String = "Trying to love someone who always love you"
    var color: Color
    var logo: String = "logo"
    var image: String
}

