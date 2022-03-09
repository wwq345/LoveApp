//
//  HomeView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/16.
//

import SwiftUI

struct HomeView: View {
    @State var ifAlert: Bool = false
    @State var showProfile: Bool = false
    @State var showUpdate: Bool = false
    @State var menuPosition: CGSize = CGSize.zero
    @State var showContentWithRing: Bool = false
    @EnvironmentObject var userStore: UserDataStore
//    @StateObject var userStore: UserStore
    @Binding var ifshowtabBar: Bool
    var userindex: Int
    var body: some View {
        ZStack {
            
            Color("Color2")
                .edgesIgnoringSafeArea(.all)
            
            
            
//            Home(showProfile:self.$showProfile, showUpdate: self.$showUpdate, showContentWithRing: self.$showContentWithRing, userStore: .constant(self.userStore))
//                .environmentObject(self.userStore)
//            Home(showProfile:self.$showProfile, showUpdate: self.$showUpdate, showContentWithRing: self.$showContentWithRing)
//                .environmentObject(self.userStore)
            Home(ifAlert: self.$ifAlert, showProfile:self.$showProfile, showUpdate: self.$showUpdate, showContentWithRing: self.$showContentWithRing, userindex: self.userindex)
                .environmentObject(self.userStore)
                .environmentObject(HomeCardDataList(cardDataList:[
                    homeCardData(title: "How to Love", color: Color("Color1"),image: "cloud"),
                    homeCardData(title: "who to Love", color: Color("Color2"),image: "mountain"),
                    homeCardData(title: "when to Love", color: Color("Color3"),image: "sunset"),
                    homeCardData(title: "where to Love", color: Color("Color4"),image: "grass"),
                    homeCardData(title: "The day you meet", color: Color("Color8"), image: "sea")
                ]))
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
            
            if self.userStore.userDataList[self.userindex].showLogin{
                ZStack {
                    LoginView(userindex: self.userindex)
                        .environmentObject(self.userStore)
                        .onAppear(){
                            self.ifshowtabBar = false
                        }
                        .onDisappear(){
                            self.ifshowtabBar = true
                        }

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
                        self.userStore.userDataList[self.userindex].showLogin = false
                    }
                }
            }
            
            MenuView(userStore: self.userStore, showProfile: self.$showProfile, index: self.userindex)
//                .environmentObject(self.userStore)
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
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(ifshowtabBar: .constant(true), userindex: 0)
            .environmentObject(UserDataStore(userDataList: [UserData(username: "wwq", avatar: "boy")]))
    }
}



let screen = UIScreen.main.bounds
