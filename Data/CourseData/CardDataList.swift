//
//  CardDataList.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/21.
//

import Foundation
import UserNotifications

class CardDataList: ObservableObject{
    @Published var dataList: [CardData]
    var count: Int = 0
    
    init(){
        self.dataList = []
    }
    
    init(dataList: [CardData]){
        self.dataList = []
        for item in dataList{
            self.dataList.append(CardData(id:self.count, text: item.text,title: item.title, Image: item.Image, isFavorite: item.isFavorite))
            count += 1
        }
    }
    
    func add(data: CardData){
        self.dataList.append(CardData(id:self.count, text: data.text, title: data.title, Image: data.Image))
        count += 1
    }
}



struct CardData: Identifiable,Codable{
    var id: Int = 0
    var text: String = " "
    var title: String = " "
    var Image: String = "love"
    var content: String = " "
    var isFavorite: Bool = false
    
    func forTest(value: Int) -> Int{
        return value + 9
    }
    
}


