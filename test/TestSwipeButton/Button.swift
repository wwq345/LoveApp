//
//  Button.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/31.
//

import SwiftUI

let buttonWidth: CGFloat = 100

enum CellButtons: Identifiable{
    case delete

    var id: String{
        return "\(self)"
    }
}

struct CellButtonView: View{

    let data: CellButtons
    let cellHeight: CGFloat

    func getImages(for image: String, title: String) -> some View{
        VStack{
            Image(systemName: image)
            Text(title)
        }
        .padding(5)
        .foregroundColor(.primary)
        .font(.subheadline)
        .frame(width: buttonWidth, height: cellHeight)
    }

    var body: some View{
        switch data {
        case .delete:
            getImages(for: "delete.right", title: "Delete")
                .background(Color.red)
        }
    }
}

struct SwipeButtonCell: ViewModifier{
    enum VisibleButton{
        case none
        case left
        case right
    }
    @State private var offset: CGFloat = 0
    @State private var oldOffset: CGFloat = 0
    @State private var visibleButton: VisibleButton = .none
    var trailingButtons: [CellButtons] = []
    var leadingButtons: [CellButtons] = []
    let minTrailingOffset: CGFloat
    let maxLeadingOffset: CGFloat
    let onClick: (CellButtons) -> Void

    init(leadingButtons: [CellButtons], trailingButtons: [CellButtons], onClick: @escaping (CellButtons) -> Void) {
        self.leadingButtons = leadingButtons
        self.trailingButtons = trailingButtons
        maxLeadingOffset = CGFloat(leadingButtons.count) * buttonWidth
        minTrailingOffset = CGFloat(trailingButtons.count) * buttonWidth * -1
        self.onClick = onClick
    }

    func reset(){
        visibleButton = .none
        offset = 0
        oldOffset = 0
    }

    func body(content: Content) -> some View {
        ZStack{
            content
                .contentShape(Rectangle())
                .offset(x: offset)
                .gesture(
                    DragGesture(minimumDistance: 15, coordinateSpace: .local)
                        .onChanged({ (newValue) in
                            let totalSlide = newValue.translation.width + oldOffset
                            if (0...Int(maxLeadingOffset) ~= Int(totalSlide)) || (Int(minTrailingOffset)...0 ~= Int(totalSlide)){
                                withAnimation {
                                    offset = totalSlide
                                }
                            }
                        })
                        .onEnded({ value in
                            withAnimation {
                                if visibleButton == .left && value.translation.width < -20 {
                                    //dismiss button
                                    reset()
                                } else if visibleButton == .right && value.translation.width > 20 {
                                    reset()
                                } else if offset > 25 || offset < -25{
                                    if offset > 0{
                                        visibleButton = .left
                                        offset = maxLeadingOffset
                                    } else {
                                        visibleButton = .right
                                        offset = minTrailingOffset
                                    }
                                    oldOffset = offset
                                } else {
                                    reset()
                                }
                            }
                        })
                )
            GeometryReader { proxy in
                HStack(spacing: 0){
                    HStack(spacing: 0) {
                        ForEach(leadingButtons) { buttonData in
                            Button {
                                withAnimation {
                                    reset()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                    onClick(buttonData)
                                }
                            } label: {
                                CellButtonView.init(data: buttonData, cellHeight: proxy.size.height)
                            }

                        }
                    }
                    .offset(x: (-1 * maxLeadingOffset) + offset)

                    Spacer()

                    HStack(spacing: 0) {
                        ForEach(trailingButtons) { buttonData in
                            Button {
                                withAnimation {
                                    reset()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    onClick(buttonData)
                                }
                            } label: {
                                CellButtonView.init(data: buttonData, cellHeight: proxy.size.height)
                            }
                        }
                    }
                    .offset(x: (-1 * minTrailingOffset) + offset)
                }
            }
        }
    }
}

extension View {
    func addButtonActions(leadingButtons: [CellButtons], trailingButtons: [CellButtons], onClick: @escaping (CellButtons) -> Void) -> some View {
        self.modifier(SwipeButtonCell(leadingButtons: leadingButtons, trailingButtons: trailingButtons, onClick: onClick))
    }
}



