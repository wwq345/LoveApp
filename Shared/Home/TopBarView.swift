//
//  TopBarView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/17.
//

import SwiftUI



struct TopBarView: View {
    enum Tab: Int{
        case first
        case second
        case third
    }
    
    @State private var selectedTab = Tab.first
    @State var ifshowTabBar: Bool = true
    @StateObject var userStore = UserDataStore(userDataList: [
        UserData(username: "wwq", avatar: "boy"),
        UserData(username: "wwq1", avatar: "dogSign"),
        UserData(username: "wwq2", avatar: "logo")])
    @StateObject var cardData: CardDataList = trueCourseData
//    @EnvironmentObject var cardData: CardDataList = trueCourseData
    
   
    
    var body: some View{
        
        VStack {
            ZStack{
                if selectedTab == .first{
//                    var userindex = userStore.userDataList.firstIndex { item in
//                        item.isLogged == true
//
//                    }
                    HomeView(ifshowtabBar: self.$ifshowTabBar, userindex: 2)
                        .environmentObject(self.userStore)
                }else if selectedTab == .second{
                    VStack{
                        DateCourseListView(ifshowTabBar: self.$ifshowTabBar)
                            .environmentObject(self.cardData)
                        if self.ifshowTabBar{
                            tabBarView
                        }

                    }
                }else if selectedTab == .third{
                    
                    VStack(spacing: 10){
                        UpdateView()
                        tabBarView
                    }
                    
                    
                }
            }
            
            if selectedTab == .first && self.ifshowTabBar {
                tabBarView
            }
        }
        
        
    }
    
    var tabBarView: some View{
        VStack(alignment: .center){
            HStack(spacing: 40){
                tabBarItem(.first, title: "Home", icon: "play.circle.fill")
                tabBarItem(.second, title: "Love Course", icon: "rectangle.stack.fill")
                tabBarItem(.third, title: "Update love", icon: "heart.fill" )
            }
            .padding()
            .frame(height: 40)
        }
    }
    
    func tabBarItem(_ tab: Tab, title: String, icon: String ) -> some View{
        ZStack{
            VStack(){
                Spacer()
                VStack{
                    Image(systemName: icon)
                        .imageScale(.large)
                }
                Text(title)
                    .font(.footnote)
            }
            
            
        }
        .frame(width: 100)
        
        .onTapGesture {
            selectedTab = tab
        }
    }

}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}


//var body: some View {
//    ZStack {
//        TabView{
//            HomeView(userStore: UserStore())
//                .tabItem(){
//                Image(systemName: "play.circle.fill")
//                Text("Home")
//            }
//
//            DateCourseListView(cardData: truecardList).tabItem(){
//                Image(systemName: "rectangle.stack.fill")
//                Text("Love Course")
//            }
//
//            UpdateView().tabItem(){
//                Image(systemName: "heart")
//                Text("Update your love")
//            }
//        }
//    }
//}


var trueCourseData: CardDataList = CardDataList(dataList:[
    CardData(text: "Course1", title: "How to Introduce yourself", Image: "love"),
    CardData(text: "Course2", title: "How to Attract dating person", Image: "love"),
    CardData(text: "Course3", title: "How to Introduce yourself", Image: "love"),
    CardData(text: "Course4", title: "How to Introduce yourself", Image: "love"),
    CardData(text: "Course5", title: "How to Introduce yourself", Image: "love")
])
