//
//  TestFunctionView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/2/23.
//

import SwiftUI

struct TestFunctionView: View {
    
    @EnvironmentObject var testData: TestdataList
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(self.testData.testList) { item in
                    NavigationLink(destination:
                                    TestIfCanChange(index: item.id)
                                    .environmentObject(self.testData)){
                        Text("Hello world")
                    }
                    
                }
                
            }
        }

    }
}

struct TestFunctionView_Previews: PreviewProvider {
    static var previews: some View {
        TestFunctionView()
            .environmentObject(
                TestdataList(testList: [
                    testdata(changed: false),
                    testdata(changed: false),
                    testdata(changed: false),
                    testdata(changed: false),
                    testdata(changed: false)
                ])
            )
    }
}
