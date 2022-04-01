//
//  HomeView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/16.
//

import SwiftUI

struct HomeView: View {
    @State var showProfile: Bool = false
    @State var showUpdate: Bool = false
    @State var menuPosition: CGSize = CGSize.zero
    @State var showContentWithRing: Bool = false
    @EnvironmentObject var userStore: UserStore
    
    var body: some View {
        ZStack {
            
            Color("Color2")
                .edgesIgnoringSafeArea(.all)
            
            
            
//            Home(showProfile:self.$showProfile, showUpdate: self.$showUpdate, showContentWithRing: self.$showContentWithRing, userStore: .constant(self.userStore))
            Home(showProfile:self.$showProfile, showUpdate: self.$showUpdate, showContentWithRing: self.$showContentWithRing)
                .environmentObject(self.userStore)
//            顺序很重要
                .padding(.top, 44)
                .background(Color.white.opacity(self.showProfile ? Double(self.menuPosition.height / 10 + 1) : 1))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .offset(y: self.showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: self.showProfile ? -10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(self.showProfile ? 0.9 : 1)
                .edgesIgnoringSafeArea(.all)
                .animation(.spring(), value: self.showProfile)
            
            
            
            
            if showContentWithRing{
                
                Color.white.edgesIgnoringSafeArea(.all)
                
                ContentView()
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(.black)
                        .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(), value: self.showContentWithRing)
                .onTapGesture {
                    self.showContentWithRing = false
                }
            }
            
            
            MenuView(showProfile: self.$showProfile)
                .environmentObject(self.userStore)
                .background(Color.black.opacity(0.001))
                .offset(y: self.showProfile ? 0 : screen.height)
                .offset(y: self.menuPosition.height)
                .animation(.spring(), value: self.showProfile)
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged() { value in
                        self.menuPosition = value.translation
                    }
                        .onEnded(){ value in
                            if self.menuPosition.height > 50{
                                self.showProfile = false
                            }
                            self.menuPosition = .zero
                        }
                )
            
            if self.userStore.showLogin{
                ZStack {
                    LoginView()
                        .environmentObject(self.userStore)

                    VStack{
                        HStack {
                            Spacer()

                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(.black)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        self.userStore.showLogin = false
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserStore())
    }
}



let screen = UIScreen.main.bounds
