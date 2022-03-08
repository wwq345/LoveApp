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
    
    init(){
        self.updateList = [
            updateData(title: "Love exceptations", image: "dogSign", text: "here is your love", date: "2001"),
            updateData(title: "Love experience", image: "cloud", text: "here is experience", date: "2002"),
            updateData(title: "Love failure", image: "boy", text: "here is failure", date: "2003")
        ]
    }
    
    init(data: [updateData]){
        self.updateList = []
        for item in data{
            self.updateList.append(updateData(title: item.title, image: item.image, text: item.text, date: item.date))
        }
    }
}

struct updateData: Identifiable{
    var id = UUID()
    var title: String
    var image: String
    var text: String
    var date: String
}

let updateList: [updateData] = [
    updateData(title: "Love expectations ", image: "dogSign", text: "here is your love", date: "2001"),
    updateData(title: "Love experience", image: "cloud", text: "here is experience", date: "2002"),
    updateData(title: "Love failure", image: "boy", text: "here is failure", date: "2003")
]
