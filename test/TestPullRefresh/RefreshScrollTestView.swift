//
//  RefreshScrollTestView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/25.
//

import SwiftUI

struct RefreshScrollTestView: View {
    @State var refreshing: Bool = false
    var body: some View {
        ScrollView {
            RefreshScrollView(refreshing: self.$refreshing) {
                VStack {
                    ForEach(0..<7) { _ in
                        Text("wwq")
                    }
                }
            }
        }
    }
}

struct RefreshScrollTestView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshScrollTestView()
    }
}
