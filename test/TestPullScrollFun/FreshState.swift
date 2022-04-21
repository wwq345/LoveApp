//
//  FreshState.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/20.
//

import Foundation
import SwiftUI


enum RefreshState: Int {
    case invalid
    case stopped
    case triggered
    case loading
}

struct RefreshData {
    var thresold: CGFloat = 0
    var progress: Double = 0
    var refreshState: RefreshState = .invalid
}

struct HeaderRefreshDatakey: EnvironmentKey {
    static var defaultValue: RefreshData = .init()
}

struct FooterRefreshDataKey: EnvironmentKey {
    static var defaultValue: RefreshData = .init()
}

extension EnvironmentValues {
    var headerRefreshData: RefreshData {
        get { self[HeaderRefreshDatakey.self] }
        set { self[HeaderRefreshDatakey.self] =  newValue }
    }
    
    var footerRefreshData: RefreshData {
        get { self[FooterRefreshDataKey.self] }
        set { self[FooterRefreshDataKey.self] =  newValue }
    }
}

struct HeaderBoundsPreferenceKey: PreferenceKey {
    struct Item {
        let bounds: Anchor<CGRect>
    }
    static var defaultValue: [Item] = []
    
    static func reduce(value: inout [Item], nextValue: () -> [Item]) {
        value.append(contentsOf: nextValue())
    }
}

struct FooterBoundsPreferenceKey: PreferenceKey {
    struct Item {
        let bounds: Anchor<CGRect>
    }
    static var defaultValue: [Item] = []
    
    static func reduce(value: inout [Item], nextValue: () -> [Item]) {
        value.append(contentsOf: nextValue())
    }
}
