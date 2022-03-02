//
//  TestFunctionView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/2/23.
//

import SwiftUI

struct TestFunctionView: View {
    
    @State var reason: String = "dsad"
    
    var body: some View {
       
        Button {
            print(reason)
        } label: {
            Text("tell me why")
        }

    }
}

struct TestFunctionView_Previews: PreviewProvider {
    static var previews: some View {
        TestFunctionView()
    }
}
