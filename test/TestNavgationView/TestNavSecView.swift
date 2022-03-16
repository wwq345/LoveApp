//
//  TestNavSecView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/10.
//

import SwiftUI

struct TestNavSecView: View {
    
    @EnvironmentObject var data: testNavDataList
    var index: Int
    var body: some View {
        VStack {
            VStack {
                Text("what the hell")
                    .font(.title)
                .foregroundColor(Color.orange)
                
                Image(systemName: self.data.list[index].change ? "star.fill" : "star")
                    .imageScale(.large)
                    .onTapGesture {
                        self.data.list[index].change.toggle()
                    }
                
                Image("boy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 200, height: 200)
        .background(Color.blue)
        .padding(.top)
            
            Spacer()
        }
    }
}

struct TestNavSecView_Previews: PreviewProvider {
    static var previews: some View {
        TestNavSecView(index: 1)
            .environmentObject(testNavDataList(data: [testNavData(change: false)]))
    }
}


