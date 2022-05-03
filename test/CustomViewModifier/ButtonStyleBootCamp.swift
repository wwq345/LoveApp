//
//  ButtonStyleBootCamp.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/25.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .brightness(configuration.isPressed ? 0.6 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct ButtonStyleBootCamp: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Click Me")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
            
        }
        .buttonStyle(PressableButtonStyle())
        .padding(40)

    }
}

struct ButtonStyleBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyleBootCamp()
    }
}
