//
//  ButtonDesignView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/2/23.
//

import SwiftUI

func haptic(type: UINotificationFeedbackGenerator.FeedbackType){
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}


struct Buttons: View {
    
    @State var onPress: Bool = false
    @State var onPress2: Bool = false
    @State var onPress3: Bool = false
    
    var body: some View {
        VStack(spacing: 60){
            ButtonView(onPress: self.$onPress)
            
            CircleView(onPress: self.$onPress2)
            
            PayButtonView(onPress: self.$onPress3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Color11"))
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0),value: [onPress,onPress2,onPress3])
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

struct ButtonView: View {
    
    @State var onTap: Bool = false
    @Binding var onPress: Bool
    
    var body: some View {
        Text("Button")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 200, height: 60)
            .background(
                ZStack {
                    Color("Color7")
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.white)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("Color11"), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                    
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(Color.white.opacity(self.onPress ? 0 : 1))
                        .frame(width: self.onPress ? 64 : 54 , height: self.onPress ? 4 : 50)
                        .background(Color("Color5")).opacity(0.7)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color("Color5"), radius: 8, x: 8, y: 8)
                        .offset(x: self.onPress ? 70 : 0, y: self.onPress ? 16 : 0)
                    
                    Spacer(minLength: 20)
                    
                }
                
            )
            .shadow(color: self.onPress ? Color.white : Color("Color12"), radius: 20, x: 20, y: 20)
            .shadow(color: self.onPress ? Color("Color12") : Color.white, radius: 20, x: -20, y: -20)
            .scaleEffect(self.onTap ? 1.2 : 1)
            .gesture(
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 10).onChanged()
                { value in
                    self.onTap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.onTap =  false
                    }
                }
                    .onEnded(){ value in
                        self.onPress.toggle()
                    }
            )
    }
}

struct CircleView: View {
    
    @Binding var onPress: Bool
    @State var onTap: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "sun.max")
                    .font(.system(size: 44, weight: .light))
                    .offset(x: self.onPress ? -90 : 0, y: self.onPress ? -90 : 0)
                .rotation3DEffect(Angle(degrees: self.onPress ? 20 : 0), axis: (x: 10, y: -10, z: 0))
                
                Image(systemName: "moon.fill")
                    .font(.system(size: 44, weight: .light))
                    .offset(x: self.onPress ? 0 : 90, y: self.onPress ? 0 : 90)
                .rotation3DEffect(Angle(degrees: self.onPress ? 0 : 20), axis: (x: -10, y: 10, z: 0))
            }
        }
        .frame(width: 100, height: 100)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [self.onPress ? Color("Color7") : Color.white, self.onPress ? Color.white : Color("Color7")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Circle()
                    .stroke(Color("Color12").opacity(0.01),lineWidth: 5)
                    .shadow(color: Color("Color12"), radius: 3, x: self.onPress ? 5 : -5, y: self.onPress ? 5 : -5)
                
                Circle()
                    .stroke(Color.white.opacity(0), lineWidth: 10)
                    .shadow(color: Color.white, radius: 3, x: 3, y: 3)
                
            }
        )
        .clipShape(Circle())
        .shadow(color: Color("Color12"), radius: 20, x: self.onPress ? -20 : 20, y: self.onPress ? -20 : 20)
        .shadow(color: Color.white, radius: 20, x:self.onPress ? 20 :  -20, y:self.onPress ? 20 : -20)
        .scaleEffect(onTap ? 1.2 : 1)
        .gesture(
            LongPressGesture().onChanged(){ value in
                self.onTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.onTap =  false
                }
            }
                .onEnded(){ value in
                    self.onPress.toggle()
                }
        )
    }
}

struct PayButtonView: View {

    @Binding var onPress: Bool
    @GestureState var onTap: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
               Image("fingerprint")
                    .opacity(self.onPress ? 0 : 1)
                    .scaleEffect(self.onPress ? 0 : 1)
                
               Image("fingerprint-2")
                    .clipShape(Rectangle().offset(y: self.onTap ? 0 : 50))
                    .animation(.easeInOut, value: self.onTap)
                    .opacity(self.onPress ? 0 : 1)
                    .scaleEffect(self.onPress ? 0 : 1)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 55, weight: .light))
                    .foregroundColor(Color("Color0"))
                    .opacity(self.onPress ? 1 : 0)
                    .scaleEffect(self.onPress ? 1 : 0)
            }
        }
        .frame(width: 100, height: 100)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [self.onPress ? Color("Color7") : Color.white, self.onPress ? Color.white : Color("Color7")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                Circle()
                    .stroke(Color("Color12").opacity(0.01),lineWidth: 5)
                    .shadow(color: Color("Color12"), radius: 3, x: self.onPress ? 5 : -5, y: self.onPress ? 5 : -5)
                
                Circle()
                    .stroke(Color.white.opacity(0), lineWidth: 10)
                    .shadow(color: Color.white, radius: 3, x: 3, y: 3)
                
            }
        )
        .clipShape(Circle())
        .overlay(
            Circle()
                .trim(from: self.onTap ? 0.001 : 1, to: 1)
                .stroke(LinearGradient(colors: [Color("Color0"), Color("Color8")], startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 90, height: 90)
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .animation(.easeInOut(duration: 0.2), value: self.onTap)
        )
        .shadow(color: Color("Color12"), radius: 20, x: self.onPress ? -20 : 20, y: self.onPress ? -20 : 20)
        .shadow(color: Color.white, radius: 20, x:self.onPress ? 20 :  -20, y:self.onPress ? 20 : -20)
        .scaleEffect(onTap ? 1.2 : 1)
        .gesture(
            LongPressGesture().updating(self.$onTap){ currentState, gestureState, transaction in
                gestureState = currentState
                impact(style: .medium)
            }
                .onEnded(){ value in
                    self.onPress.toggle()
                    haptic(type: .success)
                }
        )
    }
}

