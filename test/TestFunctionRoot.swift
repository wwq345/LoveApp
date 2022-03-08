//
//  TestFunctionRoot.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/8.
//

import SwiftUI

struct TestFunctionRoot: View {
    
    @StateObject var testData: TestdataList = TestdataList(testList: [
        testdata(changed: false),
        testdata(changed: false),
        testdata(changed: false),
        testdata(changed: false),
        testdata(changed: false),
        testdata(changed: false)
    ])
    
    var body: some View {
        TabView{
            EmptyView().tabItem {
                Image(systemName: "star.fill")
                    .imageScale(.large)
                    .background(.black)
            }
            
            TestFunctionView()
                .environmentObject(self.testData)
                .tabItem {
                    Image(systemName: "person.fill")
                        .imageScale(.large)
                        .background(Color.blue)
                }
        }
    }
}

struct TestFunctionRoot_Previews: PreviewProvider {
    static var previews: some View {
        TestFunctionRoot()
    }
}
