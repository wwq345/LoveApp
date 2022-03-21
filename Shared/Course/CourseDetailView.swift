//
//  CourseDetailView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/11.
//

import SwiftUI



struct CourseDetailView: View {
//    @StateObject var cardData: CardDataList
    @EnvironmentObject var cardData: CardDataList
    var index: Int
    
    var body: some View{
        VStack {
            HeadView(index: self.index)
                .environmentObject(self.cardData)
            
            ScrollView {
                AdviceView(index: self.index)
                    .frame(width: screen.width-40, height:screen.height - 100)
                    .padding(.top, 20)
                    .offset(y: -20)
                    .environmentObject(self.cardData)
            }
            .frame(maxHeight: screen.height)
        
        }
        .padding(30)
        .padding(.top, 30)
        .frame(maxWidth:  .infinity, maxHeight: .infinity)
        .background(Color("Color" + "\(self.index)"))
//        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
        .edgesIgnoringSafeArea(.all)
    }
}

struct AdviceView: View {
    
    @EnvironmentObject var cardData: CardDataList
    var index: Int
    var textIndex: [String] = [text1, text2, text3]
    
    var body: some View {
        
            VStack {
                Text(self.cardData.dataList[index].text)
                    .font(.title)
                    .fontWeight(.bold)
                Text(self.cardData.dataList[index].title)
                    .font(.subheadline)
                
               
                ForEach(0..<5) { item in
                    Text(textIndex[self.index])
                        .padding(10)
                        .lineSpacing(4)
                        .frame(alignment: .leading)
                }
            }
       
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        CourseDetailView(cardData: CardDataList(dataList: [
//            CardData(text: "Course1", title: "How to Introduce yourself", Image: "love"),
//            CardData(text: "Course2", title: "How to Attract dating person", Image: "love"),
//            CardData(text: "Course3", title: "How to increase romantic between you", Image: "love")
//        ]), index: 2)
        CourseDetailView(index: 0)
            .environmentObject(CardDataList(dataList: [
                CardData(text: "Course1", title: "How to Introduce yourself", Image: "love"),
                CardData(text: "Course2", title: "How to Attract dating person", Image: "love"),
                CardData(text: "Course3", title: "How to increase romantic between you", Image: "love")
            ]))
      
    }
}


struct HeadView: View {
    @EnvironmentObject var cardData: CardDataList
    var index: Int
    var body: some View {
        HStack {
            VStack {
                Text(self.cardData.dataList[self.index].text)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color5"))
                
                Text("You have learn 50%")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer(minLength: 40)
            
            
            Button(action: {
                self.cardData.dataList[index].isFavorite.toggle()
            }){
                Image(systemName: self.cardData.dataList[index].isFavorite ? "heart.fill" : "heart")
                    .imageScale(.large)
                    .foregroundColor(.pink)
                    .padding()
            }
            
            
            Image("cpuid")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 80, height: 80)
        }
    }
}

let text1 = """
1.Briefly introduce yourself.
After meeting a blind date, it is necessary to say hello and smile first, which can make the other person feel that you are polite. In short, you should first tell the other party your name, age, work and other basic information. Its also convenient for you to continue your next conversation.
"""

let text2 = """
2.Talk about your hobbies
After talking about your basic information, you can start with your hobbies. This is a good meeting to explain your personality. It is also a good opportunity to find common ground between you. You can describe what kind of person you are through what you usually do. Make it easier for the other party to understand and find the next topic.
"""

let text3 = """
3.Reminisce
Overstreet says that thinking back on tender, sensual, or sweet moments can help bring couples closer. Bring out an old Valentine’s Day card your partner gave you that was extra romantic or look at photos of your honeymoon or past trips. Taking time to remember the romantic moments you’ve shared can reignite that attraction, and pull you out of your routine (and your sweats!).
"""
