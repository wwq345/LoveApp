//
//  TopBarView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/17.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        TabView{
            HomeView().tabItem(){
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            
            DateCourseListView(cardData: truecardList).tabItem(){
                Image(systemName: "rectangle.stack.fill")
                Text("Love Course")
            }
            
            UpdateView().tabItem(){
                Image(systemName: "heart")
                Text("Update your love")
            }
        }
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}

let truecardList: CardDataList = CardDataList(dataList:
                                                [CardData(text: "Course1", title: "How to Introduce yourself", Image: "love", showAllScreen: false), CardData(text: "Course2", title: "How to Attract dating person", Image: "love", showAllScreen: false)])
