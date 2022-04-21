//
//  RefreshViewModifier.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/20.
//

import SwiftUI

extension View {
    func addPullToRefresh(isHeaderRefreshing: Binding<Bool>?, onHeaderRefresh: (() -> Void)?) -> some View {
        addPullToRefresh(isHeaderRefreshing: isHeaderRefreshing, onHeaderRefresh: onHeaderRefresh, isFooterRefreshing: nil, onFooterRefresh: nil)
    }
    
    func addPullToRefresh(isFooterRefreshing: Binding<Bool>?, onFooterRefresh: (() -> Void)?) -> some View {
        addPullToRefresh(isHeaderRefreshing: nil, onHeaderRefresh: nil, isFooterRefreshing: isFooterRefreshing, onFooterRefresh: onFooterRefresh)
    }
    
    
    func addPullToRefresh(isHeaderRefreshing: Binding<Bool>?, onHeaderRefresh: (() -> Void)?, isFooterRefreshing: Binding<Bool>?, onFooterRefresh: (() -> Void)?) -> some View {
        modifier(PullToRefreshModifier(isHeaderRefreshing: isHeaderRefreshing, isFooterRefreshing: isFooterRefreshing, onHeaderRefresh: onHeaderRefresh, onFooterRefresh: onFooterRefresh))
    }
}

struct PullToRefreshModifier: ViewModifier {
    @Binding var isHeaderRefreshing: Bool
    @Binding var isFooterRefreshing: Bool
    
    let onHeaderRefresh: (() -> Void)?
    let onFooterRefresh: (() -> Void)?
    
    init(isHeaderRefreshing: Binding<Bool>?, isFooterRefreshing: Binding<Bool>?, onHeaderRefresh: (() -> Void)?, onFooterRefresh: (() -> Void)?) {
        self._isHeaderRefreshing = isHeaderRefreshing ?? .constant(false)
        self._isFooterRefreshing = isFooterRefreshing ?? .constant(false)
        self.onHeaderRefresh = onHeaderRefresh
        self.onFooterRefresh = onFooterRefresh
    }
    
    @State private var headerRefreshData = RefreshData()
    @State private var footerRefreshData = RefreshData()
    
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .environment(\.headerRefreshData, headerRefreshData)
                .environment(\.footerRefreshData, footerRefreshData)
                .onChange(of: isHeaderRefreshing) { value in
                    if !value {
                        self.headerRefreshData.refreshState = .stopped
                    }
                }
                .onChange(of: isFooterRefreshing) { newValue in
                    if !newValue {
                        self.footerRefreshData.refreshState = .stopped
                    }
                }
    //            .onAppear {
    //                if (self.headerRefreshData.refreshState == .invalid) {
    //                    self.headerRefreshData.refreshState = .loading
    //                    self.headerRefreshData.progress = 1.0
    //                    self.isHeaderRefreshing = true
    //                    self.onHeaderRefresh?()
    //                }
    //            }
                .backgroundPreferenceValue(HeaderBoundsPreferenceKey.self) { value -> Color in
                    DispatchQueue.main.async {
                        calculateHeaderRefreshState(proxy, value: value)
                    }
                    return Color.clear
                }
        }
    }
}

extension PullToRefreshModifier {
    private func calculateHeaderRefreshState(_ proxy: GeometryProxy, value: [HeaderBoundsPreferenceKey.Item]) {
        guard let bounds = value.first?.bounds else {
            return
        }
        
        guard headerRefreshData.refreshState != .loading else {
            return
        }
        
        guard isFooterRefreshing != true else {
            return
        }
        //bounds seems like some box of header??
//        print("bounds is\(bounds)")
        let headerFrame = proxy[bounds]
//        print("proxy[bounds] is \(headerFrame)")
        let y = headerFrame.minY
//        print("headerMiny is\(headerFrame.minY)")
        //thresold is constant
        let threshold = headerFrame.height
//        print("headerheight is \(headerFrame.height)")
        let topDistance: CGFloat = 30.0
        
        if threshold != headerRefreshData.thresold {
            headerRefreshData.thresold = threshold
        }
        
        if -y == headerRefreshData.thresold && headerFrame.width == proxy.size.width && headerRefreshData.refreshState == .invalid {
            headerRefreshData.refreshState = .stopped
        }
        
        var contentOffset = y + threshold
//        print("contentOffset is \(contentOffset)")
        
        if contentOffset == 0 {
            headerRefreshData.progress = 0.0
        }
        
        guard contentOffset > topDistance else {
            return
        }
        
        contentOffset -= topDistance
        
        if contentOffset <= threshold && headerRefreshData.refreshState == .stopped && headerRefreshData.refreshState != .triggered{
            let oldProgress = headerRefreshData.progress
            //if continue to pull it will refresh even if you dont release
            let progress = Double(contentOffset / threshold)
            if progress < oldProgress {
                return
            }
            //no release no refresh
            headerRefreshData.progress = (progress >= 1.0) ? 1.0 : progress
        }
        
        if contentOffset > threshold && headerRefreshData.refreshState == .triggered && headerRefreshData.refreshState != .loading {
            headerRefreshData.refreshState = .loading
            headerRefreshData.progress = 1.0
            isHeaderRefreshing = true
            onHeaderRefresh?()
            //check state in case of state changed because the onHeaderRefresh
            if (!isHeaderRefreshing) {
                headerRefreshData.refreshState = .stopped
            }
        }
    }
    
    private func calculateFooterRefreshState(_ proxy: GeometryProxy, value: [FooterBoundsPreferenceKey.Item]) {
        //value = [content.bounds, footer.bounds]
        
        guard let bounds = value.last?.bounds else {
            return
        }
        
        guard let contentBounds = value.first?.bounds else {
            return
        }
        
        //loading so can't do anything ele
        guard footerRefreshData.refreshState != .loading else {
            return
        }
        
        // header loading so footer can't load
        guard isHeaderRefreshing != true else {
            return
        }
        
        let footerFrame = proxy[bounds]
        let contentFrame = proxy[contentBounds]
        
        //let contentTop = contentFrame.minY // 未滚动时为0，滚动后为负值
        let y = footerFrame.minY
        print("footerminY is \(y)")
        //this is same size as headerFrame.height,why?
        let threshold = footerFrame.height
        print("footerHeight is \(threshold)")
        let bottomDistance: CGFloat = 30.0
        //proxy and content both constant
        //if full of screen , scrollViewheight is screen else is content
        let scrollViewHeight = min(proxy.size.height, contentFrame.height)
        
        if threshold != footerRefreshData.thresold {
            footerRefreshData.thresold = threshold
        }
        
        if abs(y - (scrollViewHeight + footerRefreshData.thresold)) < 0.001 && footerFrame.width == proxy.size.width && footerRefreshData.refreshState == .invalid {
            footerRefreshData.refreshState = .stopped
        }
        //the distance between bottom
        var contentOffset = scrollViewHeight - y
        
        if contentOffset == 0 {
            footerRefreshData.progress = 0.0
        }
        
        guard contentOffset > bottomDistance else {
            return
        }
        
        contentOffset -= bottomDistance
        
        if contentOffset <= threshold && footerRefreshData.refreshState == .stopped {
            let progress = Double(contentOffset / threshold)
            footerRefreshData.progress = (progress >= 1.0) ? 1.0 : progress
        }
        
        if contentOffset > threshold && footerRefreshData.refreshState == .stopped && footerRefreshData.refreshState != .triggered {
            footerRefreshData.refreshState = .triggered
            footerRefreshData.progress = 1.0
        }
        
        if contentOffset <= threshold && footerRefreshData.refreshState == .triggered && footerRefreshData.refreshState != .loading {
            footerRefreshData.refreshState = .loading
            footerRefreshData.progress = 0
            isFooterRefreshing = true
            onFooterRefresh?()
            if(!isFooterRefreshing) {
                footerRefreshData.refreshState = .stopped
            }
        }
    }
}
