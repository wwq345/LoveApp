//
//  ViewModifierBootCamp.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/25.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}

extension View {
    
    func withDefaultButtonFormatting() -> some View {
       modifier(DefaultButtonViewModifier())
    }
}

struct ViewModifierBootCamp: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .withDefaultButtonFormatting()
            Text("Hello Everyone")
                .withDefaultButtonFormatting()
            Text("Hello!!")
                .withDefaultButtonFormatting()
        }
        
    }
}

struct ViewModifierBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootCamp()
    }
}
