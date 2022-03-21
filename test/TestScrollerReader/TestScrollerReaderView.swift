//
//  TestScrollerReaderView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/16.
//

import SwiftUI
import Lottie

struct TestScrollerReaderView: View {
    
    @State  var scrollToIndex: Int = 0
    @State var textField: String = " "
    
    var body: some View {
        VStack {
            
            TextField("Enter a number", text: self.$textField)
                .frame(width: 350, height: 20)
                .background(.white)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)
                .padding(.top)
            
            Button("Jump to") {
                if let index = Int(textField){
                    scrollToIndex = index
                }
            }
            
            ScrollView{
                ScrollViewReader{ proxy in
                    ForEach(0..<50){ index in
                        Text("This is number (\(index))")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(10)
                            .id(index)
                            
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                }
                
            }
        }
    }
}

struct TestScrollerReaderView_Previews: PreviewProvider {
    static var previews: some View {
        TestScrollerReaderView()
    }
}
