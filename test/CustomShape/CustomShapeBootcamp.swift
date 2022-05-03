//
//  CustomShapeBootcamp.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/26.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        //path maybe the lines that make up the shape
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: -20),
                        endAngle: Angle(degrees: 20),
                        clockwise: false)
        }
    }
}

struct Pacman: Shape {
    var offsetAmount: Double
    var animatableData: Double {
        get { offsetAmount }
        set { offsetAmount = newValue}
    }
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.minY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: offsetAmount),
                        endAngle: Angle(degrees: 360 - offsetAmount),
                        clockwise: false)
        }
    }
        
}

struct CustomShapeBootcamp: View {
    @State var animate: Bool = false
    var body: some View {
        ZStack {
            Pacman(offsetAmount: animate ? 20 : 0)
//                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
//                .foregroundColor(.blue)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 300, height: 300)
        }
        .onTapGesture {
            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct CustomShapeBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapeBootcamp()
    }
}
