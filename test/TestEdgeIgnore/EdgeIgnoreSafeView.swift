//
//  EdgeIgnoreSafeView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/28.
//

import SwiftUI

struct EdgeIgnoreSafeView: View {
    var body: some View {
        ZStack {
            Color.blue
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    ForEach(0..<7) { _ in
                        Text("sdawdwdwadsa")
                            .padding()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "square.fill")
            }
        }
    }
}

struct EdgeIgnoreSafeView_Previews: PreviewProvider {
    static var previews: some View {
        EdgeIgnoreSafeView()
    }
}
