//
//  TestSwipeButton.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/31.
//

import SwiftUI

struct TestSwipeButton: View {
    var body: some View {
        List(1..<6){_ in
            VStack{
                Text("sadw")
                    .swipeActions(leadings: [],
                                  allowsFullSwipeLeading: false,
                                  trailings:
                                    [SwipeActionButton(text: Text("delete"), icon: "delete.right", action: { print("ww") }, tint: .red)],
                                  allowsFullSwipeTrailing: false)
            }
            .frame(width: 300, height: 20)
        }
    }
}


struct TestSwipeButton_Previews: PreviewProvider {
    static var previews: some View {
        TestSwipeButton()
    }
}
