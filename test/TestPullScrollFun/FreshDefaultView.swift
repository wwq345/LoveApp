//
//  FreshDefaultView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/20.
//
import Foundation
import SwiftUI

class ListState: ObservableObject {
    @Published private(set) var noMore: Bool
    
    init(){
        noMore = false
    }
    
    func setNoMore(_ newNoMore: Bool) {
        noMore = newNoMore
    }
}

struct RefreshDefaultHeader: View {
    @Environment(\.headerRefreshData) private var headerRefreshData
    
    var body: some View {
        let state = headerRefreshData.refreshState
//        let progress = headerRefreshData.progress
        if state == .stopped {
            VStack(spacing: 0) {
                Text("pull down to refresh")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                    .frame(height: 20)
            }
        }
        
        if state == .triggered {
            VStack(spacing: 0) {
                Text("Released to refresh")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                    .frame(height: 20)
            }
        }
        
        if state == .loading {
            ProgressView("Refreshing")
                .padding()
                .frame(height: 60)
        }
        
        if state == .invalid {
            Spacer()
                .padding()
                .frame(height: 60)
        }
    }
}

struct RefreshDefaultFooter: View {
    @Environment(\.footerRefreshData) private var footerRefreshData
    @EnvironmentObject private var listState: ListState
    
    var body: some View {
        let state = footerRefreshData.refreshState
//        let progress = footerRefreshData.progress
        if state == .stopped {
            VStack {
                Text(listState.noMore ? "no more data" : "pull up to load")
                    .font(.system(size: 18))
                    .padding()
                    .frame(height: 20)
            }
        }
        
        if state == .triggered {
            VStack {
                Text("Release to load more")
                    .font(.system(size: 18))
                    .padding()
                    .frame(height: 20)
            }
        }
        
        if state == .loading {
            ProgressView("Loading")
                .padding()
                .frame(height: 60)
        }
        
        if state == .stopped {
            Spacer()
                .padding()
                .frame(height: 60)
        }
        
    }
    private func printLog(_ state: RefreshState) -> some View {
        print("\(state)")
        return EmptyView()
    }
}

struct SelfProgressViewStyle: ProgressViewStyle {
    var strokeColor = Color.pink
    var strokeWidth = 10.0
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
    }
}

struct MyCircle: Shape {
    var startAngle: Angle
    var endAngle: Angle
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return path.strokedPath(.init(lineWidth: 100, dash: [5, 3], dashPhase: 10))
    }
}

struct CustomizeProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let degrees = configuration.fractionCompleted ?? 0
        let percent = Int(configuration.fractionCompleted ?? 100)
        
        return VStack {
            MyCircle(startAngle: .degrees(1), endAngle: .degrees(degrees))
                .frame(width: 200, height: 200)
                .padding()
            Text("Task \(percent)% Complete")
        }
    }
}

