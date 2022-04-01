//
//  TestNavFirstView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/10.
//

import SwiftUI

struct TestNavFirstView: View {
    @StateObject var data: testNavDataList = testNavDataList(data: [
        testNavData(change: false),
        testNavData(change: false),
        testNavData(change: false),
        testNavData(change: true)
    ])
    
    var body: some View {
        NavigationView{
        
            List{
                ForEach(self.data.list) { item in
                    NavigationLink(destination: TestNavSecView( index: item.id)
                                        .environmentObject(self.data))
                        {
                            VStack {
                                Text("what the hell")
                                    .font(.title)
                                .foregroundColor(Color.orange)
                                
                                Image(systemName: self.data.list[item.id].change ? "heart.fill" : "heart")
                                    .imageScale(.large)
                                    .onTapGesture {
                                        self.data.list[item.id].change.toggle()
                                    }
                                
                                Image("boy")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            .frame(width: 200, height: 200)
                            .background(Color.blue)
                    }
                    .navigationTitle(Text("sadada"))
                }
            }
        }
    }
}

struct TestNavFirstView_Previews: PreviewProvider {
    static var previews: some View {
        TestNavFirstView()
    }
}

class testNavDataList: ObservableObject{
    @Published var list: [testNavData]
    var index: Int = 0
    
    init(){
        self.list = []
    }
    
    init(data: [testNavData]){
        self.list = []
        for item in data{
            self.list.append(testNavData(id:self.index, change: item.change))
            index += 1
        }
    }
}

struct testNavData: Identifiable{
    var id: Int = 0
    var change: Bool = false
}
