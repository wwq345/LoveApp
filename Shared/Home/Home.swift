//
//  Home.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/17.
//

import SwiftUI

struct Home: View {
    //@State var ifAlert: Bool(userStore.islogged)
    @Binding var ifAlert: Bool
    var errorMessage: String = "Please sign"
    @Binding var showProfile: Bool
    @Binding var showUpdate: Bool 
    @Binding var showContentWithRing: Bool
    @EnvironmentObject var userStore: UserDataStore
//    @StateObject var userStore: UserStore
//    @Binding var userStore: UserStore
    @EnvironmentObject var homeCardData: HomeCardDataList
    var userindex: Int
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    ChangeToMenuView(showProfile: self.$showProfile, userindex: self.userindex)
                        .environmentObject(self.userStore)
//                    ChangeToMenuView(userStore: .constant(self.userStore),showProfile: self.$showProfile)
                        
                    
                    Button(action: {
                        if self.userStore.userDataList[self.userindex].isLogged{
                            self.showUpdate.toggle()
                        }else{
                            self.ifAlert = true
                        }
                    }){
                        Image(systemName: "bell")
                            .imageScale(.large)
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 1)
                    }
                    .alert(isPresented: self.$ifAlert){
                        Alert(title: Text("Not Logged"), message: Text(self.errorMessage), dismissButton: .default(Text("Go Login")))
                    }
                    .sheet(isPresented: self.$showUpdate, onDismiss: {}){
                        UpdateView()
                    }
                }
                .padding(.horizontal)
                .padding(.top, 30)
            
                
                WatchRingView()
                    .padding(.horizontal,30)
                    .onTapGesture {
                        self.showContentWithRing = true
                }
                
    //            这部分的旋转的角度变化就是卡片到屏幕左边最小距离 / -20来的，禁用x z轴的旋转，记住这样子可以得了，好难理解
                ScrollView(.horizontal){
                    HStack (spacing: 30){
                        ForEach(self.homeCardData.cardList){ item in
                            GeometryReader { geometory in
                                HomeCardView(cardData: item)
                                    .rotation3DEffect(Angle(degrees: Double(geometory.frame(in: .global).minX) / -20 ), axis: (x: 0, y: 10, z: 0)
                                    )
                            }
                            .frame(width: 375, height: 300)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 20)
                }
                
                
                VStack(alignment: .leading) {
                    Text("Love Stroy")
                        .fontWeight(.bold)
                    .font(.title)
                    
                    HomeCardView(cardData:self.homeCardData.cardList[4], width: 375, height: 300)
                }
                
                
                Spacer()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
//      这个是不是应该用什么environmentObject的那个，那个只是针对数据类型的嘛
        Home(ifAlert: .constant(false), showProfile: .constant(false), showUpdate: .constant(false), showContentWithRing: .constant(false), userindex: 0)
            .environmentObject(UserDataStore(userDataList: [UserData(username: "wwq", avatar: "boy")]))
            .environmentObject(HomeCardDataList(cardDataList:[
                homeCardData(title: "How to Love", color: Color("Color1"),image: "cloud"),
                homeCardData(title: "who to Love", color: Color("Color2"),image: "mountain"),
                homeCardData(title: "when to Love", color: Color("Color3"),image: "sunset"),
                homeCardData(title: "where to Love", color: Color("Color4"),image: "grass"),
                homeCardData(title: "The day you meet", color: Color("Color8"), image: "sea")
            ]))

//        Home(showProfile: .constant(false), showUpdate: .constant(false), showContentWithRing: .constant(false))
//            .environmentObject(UserStore())
//        Home(showProfile: .constant(false), showUpdate: .constant(false), showContentWithRing: .constant(false),userStore: .constant(UserStore()))
//            .environmentObject(UserStore())
//
    }
}

struct HomeCardView: View {
    
    var cardData: homeCardData
    var width: CGFloat = 400
    var height: CGFloat = 345
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(self.cardData.text)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.purple)
                    .frame(width: 160, alignment: .leading)
                Spacer()
                Image(self.cardData.logo)
                    .resizable()
                    .frame(width: 80, height: 80)
            }
            
            Text(self.cardData.title.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(cardData.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 150)
        }
        .padding(.top, 20)
        .frame(width: self.width, height: self.height)
        .background(self.cardData.color)
        .cornerRadius(30)
        .shadow(color: self.cardData.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}


struct WatchRingView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 30) {
                HStack {
                    RIngView(color1: Color("Color4"), color2: Color("Color7"), width: 44, height: 44, percent: 89, showCircle: .constant(true))
                    VStack(alignment:.leading, spacing: 8) {
                        Text("You have dated with her for 4 days")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("You need more days ")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                }
                .padding(8)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 5)
                
                HStack {
                    RIngView(color1: Color("Color5"), color2: Color("Color1"), width: 32, height: 32, percent: 89, showCircle: .constant(true))
                }
                .padding(8)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 5)
                
                HStack {
                    RIngView(color1: Color("Color5"), color2: Color("Color1"), width: 25, height: 25, percent: 44, showCircle: .constant(true))
                }
                .padding(8)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 5)
                
            }
        }
    }
}

struct ChangeToMenuView: View {
//    @Binding var userStore: UserStore
//    @StateObject var userStore: UserStore
    @Binding var showProfile: Bool
    @EnvironmentObject var userStore: UserDataStore
    var userindex: Int
    
    var body: some View {
        if userStore.userDataList[self.userindex].isLogged{
            Button(action: {
                self.showProfile.toggle()
            }){
                Image(self.userStore.userDataList[userindex].avatar)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
            }
        }else{
            Button(action: {
                self.userStore.userDataList[self.userindex].showLogin.toggle()
            }){
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
            }
        }
    }
}


