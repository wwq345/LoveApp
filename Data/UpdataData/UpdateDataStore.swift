//
//  UpdateDataStore.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/17.
//

import SwiftUI
import Combine


class UpdateDataStored: ObservableObject{
    @Published var updateList: [updateData]
    var index: Int = 0
    init(){
        self.updateList = [
            updateData(id: 0,title: "Love exceptations", image: "dogSign", text: "here is your love", date: "2001"),
            updateData(id: 1,title: "Love experience", image: "cloud", text: "here is experience", date: "2002"),
            updateData(id: 2,title: "Love failure", image: "boy", text: "here is failure", date: "2003")
        ]
    }
    
    init(data: [updateData]){
        self.updateList = []
        for item in data{
            self.updateList.append(updateData(id: self.index, title: item.title, image: item.image, text: item.text, date: item.date))
            index += 1
        }
    }
}

struct updateData: Identifiable{
    var id: Int = 0
    var title: String
    var image: String
    var text: String
    var date: String
}

let updateList: [updateData] = [
    updateData(id: 0,title: "Love exceptations", image: "dogSign", text: "here is your love", date: "2001"),
    updateData(id: 1,title: "Love experience", image: "cloud", text: "here is experience", date: "2002"),
    updateData(id: 2,title: "Love failure", image: "boy", text: "here is failure", date: "2003")
]
