//
//  DateCourseListView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/11.
//

import SwiftUI


struct DateCourseListView: View {
    @EnvironmentObject var cardData: CardDataList
    @Binding var ifshowTabBar: Bool
    var body: some View {
        
        
        NavigationView {
            List{
                ForEach(self.cardData.dataList) { item in
                    
                    NavigationLink(destination:
                        CourseDetailView( index: item.id)
                            .environmentObject(self.cardData)
                                    .onAppear(){
                        self.ifshowTabBar = false
                    }
                                    .onDisappear(){
                        self.ifshowTabBar = true
                    }
                                   )
                    {
                        CourseCardView(index: item.id)
                            .environmentObject(self.cardData)

                    }
                    .navigationTitle(Text("Love Course"))
                }
                .padding([.top, .bottom])
            }
            .listStyle(.plain)

        }
        
        
    }
}
       
 

struct DateCourseListView_Previews: PreviewProvider {
    static var previews: some View {
        DateCourseListView(ifshowTabBar: .constant(true))
            .environmentObject(CardDataList(dataList: [
                CardData(text: "Course1", title: "How to Introduce yourself", Image: "love"),
                CardData(text: "Course2", title: "How to Attract dating person", Image: "love"),
                CardData(text: "Course3", title: "How to increase romantic between you", Image: "love")
            ]))
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
                    
       
                    
                    Image(systemName: self.cardData.dataList[index].isFavorite ? "star.fill" : "star")
                        .imageScale(.large)
                        .foregroundColor(.pink)
                        .padding()
                        .onTapGesture {
                            self.cardData.dataList[index].isFavorite.toggle()
                        }
                    
                    
                    
                    Image("cpuid")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 80, height: 80)
                }
              
                 
                Spacer()

                
                Image("love")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 120, alignment: .top)
            }
            .frame(maxWidth: screen.width - 10, maxHeight: 300)
            .background(Color("Color" + "\(self.index)"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
        
        
    }
}

