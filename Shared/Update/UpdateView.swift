//
//  UpdateView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/17.
//

import SwiftUI

struct UpdateView: View{
    
    @ObservedObject var updateStore = UpdateDataStored()
    
    
    func addUpdateData(){
        updateStore.updateList.append(
            updateData(title: "ContentView", image: "dogSign", text: "here is ContentView", date: "2001"))
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(updateStore.updateList){ item in
                    NavigationLink(destination: UpdateDetailView(updateData: item)
                    ){
                        HStack {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .padding(.trailing, 4)
                            
                            VStack(alignment: .leading, spacing: 8){
                                Text(item.title)
                                    .font(.system(size: 20, weight: .bold))
                                
                                Text(item.text)
                                    .lineLimit(3)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                
                                Text(item.date)
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete(){ index in
                    self.updateStore.updateList.remove(at: index.first!)
                }
                .onMove(){ (source: IndexSet, destination: Int) in
                    self.updateStore.updateList.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationTitle(Text("Upgrades"))
            .navigationBarItems(leading: Button(action: {
                self.addUpdateData()
            }){
                Text("Add Update")
            }, trailing: EditButton())
        }
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }
}


