//
//  ContentView.swift
//  Shared
//
//  Created by i564206 on 2022/2/15.
//

import SwiftUI

struct ContentView: View {
    
    @State var ifshow: Bool = false
    @State var viewPosition: CGSize = CGSize.zero
    @State var showCard: Bool = false
    @State var hideBottomCard: CGSize = CGSize.zero
//  @State var isFull(是emmm当wordview在最上方的时候，添加这个属性使其在回拉的时候能从最上方开始，否则是要先回原点在从头来)
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: ifshow ? 30.0 : 0.0)
                .offset(y: showCard ? -200 : 0)
                .blur(radius: showCard ? 30 : 0)
                .animation(.default, value: self.showCard)
            BackgroundView(color: "Color3")
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 20 : 30, style: .continuous))
                .offset(y: -20)
                .shadow(radius: 20.0)
                .scaleEffect(self.showCard ? 0.9: 0.8)
                .offset(y: ifshow ? -190 : -25)
                .offset(y: showCard ? -300: 0)
                .offset(x: viewPosition.width, y: viewPosition.height)
                .rotationEffect(.degrees(ifshow ? 0 : 10.0))
                .rotationEffect(.degrees(showCard ? -10.0 : 0))
                .animation(.easeInOut(duration: 0.5), value: self.viewPosition)
                .animation(.easeInOut(duration: 0.5), value: self.showCard)
            BackgroundView(color: "Color4")
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 20 : 30, style: .continuous))
                .offset(y: -20)
                .shadow(radius: 20.0)
                .scaleEffect(self.showCard ? 1 : 0.9)
                .offset(y: ifshow ? -100 : -15)
                .offset(y: showCard ? -200 : 0)
                .offset(x: viewPosition.width, y: viewPosition.height)
                .rotationEffect(.degrees(ifshow ? 0 : 5.0))
                .rotationEffect(.degrees(showCard ? -5.0 : 0))
                .animation(.easeInOut(duration: 0.3), value: self.viewPosition)
                .animation(.easeInOut(duration: 0.5), value: self.showCard)
            CardView()
                .frame(width: showCard ? 410: 340.0, height: 250.0)
                .background(Color("Color0"))
                .shadow(radius: 20.0)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .offset(x: viewPosition.width, y: viewPosition.height)
                .offset(y: showCard ? -100 : 0)
                .animation(.spring(response: 0.3), value: self.viewPosition)
                .animation(.easeInOut(duration: 0.5), value: self.showCard)
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture().onChanged(){ value in
                        self.viewPosition = value.translation
                        self.ifshow = true
                    }
                        .onEnded(){ value in
                            self.viewPosition = .zero
                            self.ifshow = false
                        }
                )
            
            WordView(showCircle: self.$showCard)
                .offset(y: showCard ? 500 : 1000)
                .offset(y: self.hideBottomCard.height)
                .gesture(
                    DragGesture().onChanged(){ value in
                        self.hideBottomCard = value.translation
                    }
                        .onEnded(){ value in
                            if self.hideBottomCard.height > 50{
                                self.showCard = false
                            }
                            if self.hideBottomCard.height < -100{
                                self.hideBottomCard.height = -300
                            }else{
                                self.hideBottomCard = .zero
                            }
                        }
                )
                .animation(.timingCurve(0.2, 0.8, 0.2, 1,duration: 0.8), value: self.showCard)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("Cute Dog")
                        .font(.title)
                        .fontWeight(.medium)
                    Text("Have a good love!")
                        .foregroundColor(Color("Color1"))
                }
                Spacer()
            }
            .padding(.horizontal,20)
            Spacer()
            Image("dogSign")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding([.leading, .bottom])
                .frame(width: 200, height: 100)
                .offset(y: -25.0)
                
        }
        
    }
}

struct BackgroundView: View {
    
    var color: String = " "
    
    var body: some View {
        VStack{
            Spacer()
        }
        .frame(width: 350.0, height: 200.0)
        .background(Color(self.color))
        
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Love Meet")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            Image("cloud")
                .resizable()
                .frame(width: 425, height: 250)
                .aspectRatio( contentMode: .fill)
                .padding(.bottom)
                .offset(y: -10)
            Spacer()
        }
    }
}

struct WordView: View {
    @Binding var showCircle: Bool
    
    var body: some View {
        VStack(spacing: 20){
            Rectangle()
                .frame(width: 40, height: 10)
                .cornerRadius(3)
                .opacity(0.1)
            Text("Emmmm,I don't want to print so many words,but I have to let it beacome two rows to show if the results is what I need")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.black)
                .lineSpacing(4)
            
            HStack(spacing: 20){
                RIngView(color1: Color("Color2"), color2: Color("Color6"), width: 88, height: 88, percent: 60, showCircle: self.$showCircle)
                VStack (alignment: .leading, spacing: 8){
                    Text("The girl's favorability to you")
                        .fontWeight(.bold)
                    Text("The 12 of 20 you met grils' requirements")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            }
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20.0)
    }
}
