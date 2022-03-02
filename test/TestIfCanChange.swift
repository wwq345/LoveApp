//
//  TestIfCanChange.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/1.
//

import SwiftUI

struct TestIfCanChange: View {
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        if self.userStore.showLogin{
            ZStack {
                LoginView()
                
                VStack{
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(.black)
                            .clipShape(Circle())
                    }
                }
                .padding()
                .onTapGesture {
                    self.userStore.showLogin = false
                }
            }
        }
    }
}

struct TestIfCanChange_Previews: PreviewProvider {
    static var previews: some View {
        TestIfCanChange()
            .environmentObject(UserStore())
    }
}
