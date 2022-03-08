//
//  TestIfCanChange.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/1.
//

import SwiftUI

struct TestIfCanChange: View {
    @EnvironmentObject var testList: TestdataList
    var index: Int
    
    var body: some View {
        
        Text(self.testList.testList[index].changed ? "change" : "no change")
            .onTapGesture {
                self.testList.testList[index].changed.toggle()
            }
    }
}

struct TestIfCanChange_Previews: PreviewProvider {
    static var previews: some View {
        TestIfCanChange(index: 0)
            .environmentObject(TestdataList())
    }
}
