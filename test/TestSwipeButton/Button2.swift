//
//  Button2.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/31.
//

import SwiftUI

struct SwipeActionButton: View, Identifiable{
    static let width: CGFloat = 70
    let id = UUID()
    let text: Text?
    let icon: String?
    let action: () -> Void
    let tint: Color?
    
    init(text: Text? = nil, icon: String? = nil, action: @escaping () -> Void, tint: Color? = nil) {
        self.text = text
        self.icon = icon
        self.action = action
        self.tint = tint ?? .gray
    }
    
    var body: some View {
        ZStack{
            tint
            VStack{
                Image(systemName: icon ?? " ")
                    .foregroundColor(.white)
                if icon == nil {
                    text?
                        .foregroundColor(.white)
                }
            }
            .frame(width: SwipeActionButton.width)
        }
    }
}


struct SwipeActionView: ViewModifier{
    private static let minSwipeableWidth = SwipeActionButton.width * 0.8
    
    let leading: [SwipeActionButton]
    let allowsFullSwipeLeading: Bool
    let trailing: [SwipeActionButton]
    let allowsFullSwipedTrailing: Bool
    
    private let totalLeadingWidth: CGFloat!
    private let totalTrailingWidth: CGFloat!
    
    @State private var offset: CGFloat = 0
    @State private var preOffset: CGFloat = 0
    
    init(leading: [SwipeActionButton] = [], trailing: [SwipeActionButton] = [], allowsFullSwipeLeading: Bool = false, allowsFullSwipedTrailing: Bool = false){
        self.leading = leading
        self.trailing = trailing
        self.allowsFullSwipeLeading = allowsFullSwipeLeading && !leading.isEmpty
        self.allowsFullSwipedTrailing = allowsFullSwipedTrailing && !trailing.isEmpty
        totalLeadingWidth = CGFloat(leading.count) * SwipeActionButton.width
        totalTrailingWidth = CGFloat(trailing.count) * SwipeActionButton.width
    }
    
    private enum Edge{
        case leading, trailing
    }
    
    private func fullSwipeEnabled(edge: Edge, width: CGFloat) -> Bool{
        let threshold = abs(width) / 2
        switch (edge){
        case .leading:
            return allowsFullSwipeLeading && offset > threshold
        case .trailing:
            return allowsFullSwipedTrailing && -offset > threshold
        }
    }
        
    private func button(for button: SwipeActionButton?) -> some View {
        button?
            .onTapGesture {
                button?.action()
                offset = 0
                preOffset = 0
            }
    }
    
    private func individualButtonWidth(edge: Edge) -> CGFloat {
        switch edge {
        case .leading:
            return (offset > 0) ? (offset / CGFloat(leading.count)) : 0
        case .trailing:
            return (offset < 0) ? (abs(offset) / CGFloat(trailing.count)) : 0
        }
    }
    
    private func checkAndHandleFullSwipe(for collection: [SwipeActionButton], edge: Edge, width: CGFloat) -> Bool {
        if fullSwipeEnabled(edge: edge, width: width) {
            offset = width * CGFloat(collection.count) * 1.2
            ((edge == .leading) ? collection.first : collection.last)?.action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                offset = 0
                preOffset = 0
            }
            return true
        }else{
            return false
        }
    }
    
    func body(content: Content) -> some View {
        GeometryReader{ geo in
            HStack(spacing: 0){
                if offset > 0 {
                    if fullSwipeEnabled(edge: .leading, width: geo.size.width) {
                        button(for: leading.first)
                            .frame(width: offset, height: geo.size.height)
                    } else {
                        ForEach(leading) { actionView in
                            button(for: actionView)
                                .frame(width: individualButtonWidth(edge: .leading), height: geo.size.width)
                        }
                    }
                }
                
                content
                    .padding(.horizontal, 16)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .leading)
                    .offset(x: (offset > 0) ? 0 : offset)
                
                if offset < 0 {
                    Group{
                        if fullSwipeEnabled(edge: .trailing, width: geo.size.width) {
                            button(for: trailing.last)
                                .frame(width: -offset, height: geo.size.height)
                        } else {
                            ForEach(trailing) { actionView in
                                button(for: actionView)
                                    .frame(width: individualButtonWidth(edge: .trailing), height: geo.size.height)
                            }
                        }
                    }
                    .offset(x: offset)
                }
            }
            .animation(.spring(), value: offset)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 10, coordinateSpace: .local)
                    .onChanged({ gesture in
                        var total = gesture.translation.width + preOffset
                        if !allowsFullSwipeLeading {
                            total = min(total, totalLeadingWidth)
                        }
                        if !allowsFullSwipedTrailing {
                            total = max(total, -totalLeadingWidth)
                        }
                        offset = total
                    })
                    .onEnded({ _ in
                        if offset > SwipeActionView.minSwipeableWidth && !leading.isEmpty {
                            if !checkAndHandleFullSwipe(for: leading, edge: .leading, width: geo.size.width) {
                                offset = totalLeadingWidth
                            }
                        } else if offset < -SwipeActionView.minSwipeableWidth && !trailing.isEmpty {
                            if !checkAndHandleFullSwipe(for: trailing, edge: .trailing, width: -geo.size.width){
                                offset = -totalTrailingWidth
                            }
                        } else {
                            offset = 0
                        }
                        preOffset = offset
                    })
            )
        }
        .listRowInsets(EdgeInsets())
    }
    
}

extension View {
    func swipeActions(leadings: [SwipeActionButton] = [], allowsFullSwipeLeading: Bool = false, trailings: [SwipeActionButton] = [], allowsFullSwipeTrailing: Bool = false) -> some View{
        modifier(SwipeActionView(leading: leadings, trailing: trailings, allowsFullSwipeLeading: allowsFullSwipeLeading, allowsFullSwipedTrailing: allowsFullSwipeTrailing))
    }
}



