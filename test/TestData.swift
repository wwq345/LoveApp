//
//  TestData.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/8.
//

import Foundation

class TestdataList: ObservableObject{
    @Published var testList: [testdata]
    var index: Int = 0
    init(){
        self.testList = []
    }
    
    init(testList: [testdata]){
        self.testList = []
        for item in testList{
            self.testList.append(testdata(id: self.index, changed: item.changed))
            index += 1
        }
    }
}


struct testdata: Identifiable{
    var id: Int = 0
    var changed: Bool = false
}
