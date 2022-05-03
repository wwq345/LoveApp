//
//  ArraysBootcamp.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/25.
//

import SwiftUI

struct ArrayBootUserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [ArrayBootUserModel] = []
    @Published var filteredArray: [ArrayBootUserModel] = []
    @Published var mappedArray: [String] = []
    
    init(){
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers() {
        let user0 = ArrayBootUserModel(name: "wwq0", points: 5, isVerified: true)
        let user1 = ArrayBootUserModel(name: "wwq1", points: 15, isVerified: true)
        let user2 = ArrayBootUserModel(name: "wwq2", points: 25, isVerified: true)
        let user3 = ArrayBootUserModel(name: "wwq3", points: 59, isVerified: true)
        let user4 = ArrayBootUserModel(name: "wwq4", points: 10, isVerified: true)
        let user5 = ArrayBootUserModel(name: "wwq5", points: 9, isVerified: true)
        let user6 = ArrayBootUserModel(name: "wwq6", points: 87, isVerified: true)
        let user7 = ArrayBootUserModel(name: "wwq7", points: 66, isVerified: true)
        let user8 = ArrayBootUserModel(name: "wwq8", points: 1, isVerified: true)
        self.dataArray.append(contentsOf: [
            user0,user1,user2,user3,user4,user5,user6,user7,user8
        ])
    }
    
    func updateFilteredArray() {
        // sort
        let sortedArray = dataArray.sorted { (user1,user2) -> Bool in
            return user1.points > user2.points
       }
        
        //filter
        let filteredArray = dataArray.filter({ (user) -> Bool in
            return user.points > 50 // user.name.contains("i")
        })
        
        //map
        let mappedArray = dataArray.map { (user) -> String in
            return user.name
        }
    }
    
}

struct ArraysBootcamp: View {
    @StateObject var viewModel = ArrayModificationViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.filteredArray) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                        HStack {
                            Text("Points: \(user.points)")
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.cornerRadius(10))
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
