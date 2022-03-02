//
//  DateCourseListView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/18.
//

import SwiftUI


let text1 = """
1.Briefly introduce yourself.
After meeting a blind date, it is necessary to say hello and smile first, which can make the other person feel that you are polite. In short, you should first tell the other party your name, age, work and other basic information. Its also convenient for you to continue your next conversation.
"""

let text2 = """
2.Talk about your hobbies
After talking about your basic information, you can start with your hobbies. This is a good meeting to explain your personality. It is also a good opportunity to find common ground between you. You can describe what kind of person you are through what you usually do. Make it easier for the other party to understand and find the next topic.
"""

struct DateCourseListView: View {

    @ObservedObject var cardData: CardDataList
    
    func ifFullScreen() -> Bool{
        for item in cardData.dataList{
            if item.showAllScreen{
                return false
            }
        }
        return true
    }
    
    func showWhichFull() -> CardData? {
        for item in cardData.dataList{
            if item.showAllScreen{
                return item
            }
        }
        return nil
    }
    
    var body: some View {
        
        
//        ScrollView{
//            VStack(spacing: 30){
//
//                Text("Love Courses")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 30)
//
//                ForEach(self.cardData.dataList){item in
//                    GeometryReader{ geometry in
//                        return CourseCardView(index: item.id)
//                            .environmentObject(self.cardData)
//                            .offset(y: item.showAllScreen ? -geometry.frame(in: .global).minY : 0)
//                    }
//                    .frame(height: item.showAllScreen ? screen.height : 280)
//                    .frame(maxWidth: item.showAllScreen ? .infinity : screen.width - 40)
//                }
//            }
//        }
//        .frame(width: screen.width)
 
        if ifFullScreen(){
            ScrollView{
                VStack(spacing: 30){

                    Text("Love Courses")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)

                    ForEach(self.cardData.dataList){item in
                        GeometryReader{ geometry in
                            return CourseCardView(index: item.id)
                                .environmentObject(self.cardData)
                                .offset(y: item.showAllScreen ? -geometry.frame(in: .global).minY : 0)
                        }
                        .frame(height: item.showAllScreen ? screen.height : 280)
                        .frame(maxWidth: item.showAllScreen ? .infinity : screen.width - 40)
                    }
                }
            }
            .frame(width: screen.width)
            
        } else if let fullItem = showWhichFull() {
            CourseCardView(index: fullItem.id)
                .environmentObject(self.cardData)
                .frame(height: fullItem.showAllScreen ? screen.height : 280)
                .frame(maxWidth: fullItem.showAllScreen ? .infinity : screen.width - 40)
        }
    }
}

struct DateCourseListView_Previews: PreviewProvider {
    static var previews: some View {
        DateCourseListView(cardData: CardDataList(dataList: [CardData(text: "Course1", title: "How to Introduce yourself", Image: "love", showAllScreen: false), CardData(text: "Course2", title: "How to Attract dating person", Image: "love", showAllScreen: false)]))
    }
}

struct CourseCardView: View {
    @EnvironmentObject var cardData: CardDataList
    var index: Int
    
    var body: some View {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.cardData.dataList[index].text)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("Color5"))
                        Text("You have learn 50%")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 40)
                    
                    if cardData.dataList[self.index].showAllScreen{
                        Button(action: {
                            cardData.dataList[self.index].showAllScreen = false
                        }){
                            Image(systemName: "xmark")
                                .imageScale(.large)
                                .aspectRatio(contentMode:.fit)
                                .frame(width: 40, height: 40)
                                .background(.white.opacity(0.4))
                                .clipShape(Circle())
                        }
                    }
                    
                    
                    
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .padding()
                    
                    Image("cpuid")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 80, height: 80)
                }
              
                 
                Spacer()
                
                if cardData.dataList[self.index].showAllScreen{
                    AdviceView(index: self.index)
//                        .frame(width: screen.width-40, height:screen.height - 100)
                        .padding(.top, 20)
                        .offset(y: -20)
                }
                
                Image("love")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 160, alignment: .top)
            }
            .padding(cardData.dataList[self.index].showAllScreen ? 30 : 20)
            .padding(.top, cardData.dataList[self.index].showAllScreen ? 30 : 0)
            .frame(maxWidth: cardData.dataList[self.index].showAllScreen ? .infinity : screen.width - 40, maxHeight: cardData.dataList[self.index].showAllScreen ? .infinity : 280)
            .background(Color("Color2"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
            
            .onTapGesture {
                cardData.dataList[self.index].showAllScreen = true
            }
            .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0), value: self.cardData.dataList[index].showAllScreen)
            .edgesIgnoringSafeArea(.all)
     }
}

struct AdviceView: View {
    
    @EnvironmentObject var cardData: CardDataList
    var index: Int
    
    var body: some View {
        VStack {
            Text(self.cardData.dataList[index].text)
                .font(.title)
                .fontWeight(.bold)
            Text(self.cardData.dataList[index].title)
                .font(.subheadline)
            
            ScrollView {
                ForEach(0..<5) { item in
                    Text(text1)
                        .padding(10)
                        .lineSpacing(4)
                        .frame(alignment: .leading)
                }
            }
        }
    }
}


