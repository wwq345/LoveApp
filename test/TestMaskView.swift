//
//  TestMaskView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/16.
//

import SwiftUI

struct TestMaskView: View {
    @State var shineIndex: Int = 2
    var body: some View {
        starView
            .overlay {
                overlayView.mask(starView)
            }
    }
}

struct TestMaskView_Previews: PreviewProvider {
    static var previews: some View {
        TestMaskView()
    }
}

extension TestMaskView{
    private var starView: some View{
        HStack{
            ForEach(1..<6){ index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            shineIndex = index
                        }
                    }
            }
        }
    }
    
    private var overlayView: some View{
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [Color.blue,Color.red], startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(shineIndex) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
}
