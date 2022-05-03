//
//  EdgeSafeWithNav.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/28.
//

import SwiftUI

struct EdgeSafeWithNav: View {
    var body: some View {
        NavigationView {
            NavigationLink  {
                EdgeIgnoreSafeView()
            } label: {
                Text("if ok")
            }

        }
    }
}

struct EdgeSafeWithNav_Previews: PreviewProvider {
    static var previews: some View {
        EdgeSafeWithNav()
    }
}
