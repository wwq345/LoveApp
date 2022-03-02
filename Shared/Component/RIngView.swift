//
//  RIngView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/17.
//

import SwiftUI

struct RIngView: View {
    var color1: Color = Color("Color3")
    var color2: Color = Color("Color5")
    var width: CGFloat = 44
    var height: CGFloat = 44
    var percent: CGFloat = 90
    
    @Binding var showCircle:Bool
    
    var body: some View {
        
        let multipart = width / 44
        let progress = percent / 100
        
        ZStack {
            
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multipart ))
                .frame(width: self.width, height: self.height)
            
            Circle()
                .trim(from: showCircle ? 1 - progress : 1, to: 1)
                .stroke(LinearGradient(colors: [self.color1,self.color2], startPoint: .bottomLeading, endPoint: .topTrailing),
                        style: StrokeStyle(lineWidth: 5 * multipart, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0)
                )
                .animation(Animation.easeInOut.delay(0.3), value: self.showCircle)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: self.width, height: self.height)
                .shadow(color: self.color2, radius: 3 * multipart, x: 0, y: 3)
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multipart))
                .foregroundColor(Color("Color1"))
        }
    }
}

struct RIngView_Previews: PreviewProvider {
    static var previews: some View {
        RIngView(showCircle: .constant(true))
    }
}
