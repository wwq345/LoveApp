//
//  MatchedGeometryEffectBootCamp.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/26.
//

import SwiftUI

struct MatchedGeometryEffectBootCamp: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25.0)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
                    
            }
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 25.0)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
                    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffectBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectBootCamp()
    }
}

struct MatchedGeometryEffectBootCamp2: View {
    @State private var selected: String = ""
    @Namespace private var namespace2
    
    let categories: [String] = ["Home", "Popular", "Saved"]
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.5))
                            .matchedGeometryEffect(id: "category_background", in: namespace2)
                    }
                    Text(category)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    selected = category
                }
            }
        }
        .padding()
    }
}
