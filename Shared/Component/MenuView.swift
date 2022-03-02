//
//  MenuView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/16.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        VStack {
            Spacer()
            
            VStack(spacing: 30) {
                Text("dov.wang - 28% Completed")
                    .frame(width: 250, height: 40, alignment: .center)
                    .font(.subheadline)
                
                Color.white
                    .frame(width: 30, height: 6)
                    .cornerRadius(3)
                    .frame(width: 130, height:6, alignment: .leading)
                    .background(Color.black.opacity(0.15))
                    .cornerRadius(3)
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(12)
                    
                
                RowView(title: "Account", icon: "gear")
                RowView(title: "Bill", icon: "creditcard")
                RowView(title: "Sign out", icon: "person.crop.circle")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 350)
            .background(LinearGradient(colors: [Color("Color7"),Color("Color3")], startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(radius: 20, x: 0, y: 20)
        .padding(.horizontal, 30)
        .overlay(
            Image("boy")
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .offset(y: -175)
        )
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct RowView: View {
    var title: String = " "
    var icon: String = " "
    
    var body: some View {
        HStack {
            Image(systemName: self.icon)
                .font(.system(size: 20, weight: .bold, design: .default))
                .imageScale(.large)
                .frame(width: 32, height: 32)
            Text(self.title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
