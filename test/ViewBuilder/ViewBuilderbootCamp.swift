//
//  ViewBuilderbootCamp.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/26.
//

import SwiftUI

struct HeaderViewRegular: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello, World!")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text("Description")
                .font(.callout)
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ViewBuilderbootCamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular()
            HeaderViewGeneric(title: "Generic Title") {
                Text("sdww")
            }
            Spacer()
        }
    }
}

struct ViewBuilderbootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderbootCamp()
    }
}
