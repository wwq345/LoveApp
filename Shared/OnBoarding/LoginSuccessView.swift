//
//  LoginSuccessView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/1.
//

import SwiftUI

struct LoginSuccessView: View {
    
    @State var show: Bool = false
    
    var body: some View {
        VStack {
            Text("Here you Logging....")
                .font(.title)
                .opacity(self.show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.2), value: self.show)
            
            LottileView(name: "success")
                .frame(width: 400, height: 400)
                .opacity(self.show ? 1 : 0)
                .animation(Animation.linear(duration: 0.5).delay(0.4), value: self.show)
            
        }
        .padding(.top)
        .background(Color("Color5").opacity(0.4).blur(radius: 10))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color("Color5"), radius: 30, x: 0, y: 20)
        .scaleEffect(self.show ? 1 : 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.2), value: self.show)
        .onAppear {
            self.show = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(self.show ? 0.5 : 0))
        .animation(.linear(duration: 0.5), value: self.show)
        .edgesIgnoringSafeArea(.all)
 
    }
}

struct LoginSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSuccessView()
    }
}
