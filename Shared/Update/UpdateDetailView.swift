//
//  UpdateDetailView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/17.
//

import SwiftUI

struct UpdateDetailView: View {
    
    var updateData: updateData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(updateData.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                Text(updateData.text)
            }
            .navigationBarTitle(updateData.title)
        }
    }
}

struct UpdateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetailView(updateData: updateList[0])
    }
}
