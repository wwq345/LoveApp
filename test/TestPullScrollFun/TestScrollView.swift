//
//  TestScrollView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/21.
//

import SwiftUI

struct TestScrollView: View {
    
    @State private var items: [ItemWwq] = []
    // to adopt for dark mode...
    @Environment(\.colorScheme) var scheme
    
    @State private var headerRefreshing: Bool = false
    @State private var footerRefreshing: Bool = false
    
    @State private var listState = ListState()
    
    var body: some View {
        
        ScrollView {
            PullToRefreshView(header: RefreshDefaultHeader(), footer: RefreshDefaultFooter()) {
                VStack{
                    ForEach(0..<6) { _ in
                        Text("dsds")
                    }
                }
            }.environmentObject(listState)
        }
        .addPullToRefresh(isHeaderRefreshing: self.$headerRefreshing, onHeaderRefresh: {reloadData()}, isFooterRefreshing: self.$footerRefreshing, onFooterRefresh: { loadMoreData() })
        .onAppear(perform: loadData)
        
    }
    private func itemRow(_ item: ItemWwq) -> some View {
        HStack(spacing: 15) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(item.name)
                    .fontWeight(.bold)
                
                Text(item.desc)
                    .font(.caption)
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            // Button...
            Button(action: {}, label: {
                Image(systemName: "message.fill")
                    .foregroundColor(.yellow)
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .clipShape(Circle())
            })
            .padding(.trailing, -5)
            Button(action: {}, label: {
                Image(systemName: "phone.fill")
                    .foregroundColor(.yellow)
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .clipShape(Circle())
            })
        }
        .padding(.horizontal)
    }
//    var pullToRefreshScrollBody: some View {
//        headerFooterRefresh
////        headerRefresh
////        footerRefresh
//    }
//
//    // 只对头部进行数据下拉刷新
//    var headerRefresh: some View {
//        ScrollView {
//            PullToRefreshView(header: RefreshDefaultHeader()) {
//                ItemList(items: items)
//            }.environmentObject(listState)
//        }
////        .listStyle(.plain)
//        .addPullToRefresh(isHeaderRefreshing: $headerRefreshing, onHeaderRefresh: reloadData)
//    }
//    // 只对尾部进行数据上拉加载
//    var footerRefresh: some View {
//       ScrollView {
//            PullToRefreshView(footer: RefreshDefaultFooter()) {
//                ItemList(items: items)
//            }.environmentObject(listState)
//        }
////        .listStyle(.plain)
//        .addPullToRefresh(isFooterRefreshing: $footerRefreshing, onFooterRefresh: loadMoreData)
//    }
//    // 下拉刷新、上拉加载
//    var headerFooterRefresh: some View {
//        ScrollView {
//            PullToRefreshView(header: RefreshDefaultHeader(), footer: RefreshDefaultFooter()) {
//                ItemList(items: items)
//            }.environmentObject(listState)
//        }
//        .listStyle(.plain)
//        .addPullToRefresh(isHeaderRefreshing: $headerRefreshing, onHeaderRefresh: reloadData,
//                          isFooterRefreshing: $footerRefreshing, onFooterRefresh: loadMoreData)
//    }
    
    private func loadData() {
        var tempItems: [ItemWwq] = []
        for index in 0..<10 {
            if index >= itemsData.count {
                // 如果已经没有数据，则终止添加
                listState.setNoMore(true)
                break
            }
            let item = itemsData[index]
            
            tempItems.append(item)
        }
        self.items = tempItems
    }
    
    private func reloadData() {
        print("begin refresh data ...\(headerRefreshing)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            loadData()
            headerRefreshing = false
            print("end refresh data ...\(headerRefreshing)")
        }
    }
    
    private func loadMoreData() {
        print("begin load more data ... \(footerRefreshing)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let startIndex = items.count
            for index in 0..<10 {
                let finalIndex = startIndex + index
                if finalIndex >= itemsData.count {
                    // 如果已经没有数据，则终止添加
                    listState.setNoMore(true)
                    break
                }
                let item = itemsData[finalIndex]
                
                self.items.append(item)
            }
            footerRefreshing = false
            print("end load more data ... \(footerRefreshing)")
        }
    }
}

struct ItemList: View {
    let items: [ItemWwq]
    var body: some View {
        VStack {
            ForEach(items) { item in
                itemRow(item)
            }
        }
    }
    private func itemRow(_ item: ItemWwq) -> some View {
        HStack(spacing: 15) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(item.name)
                    .fontWeight(.bold)
                
                Text(item.desc)
                    .font(.caption)
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            // Button...
            Button(action: {}, label: {
                Image(systemName: "message.fill")
                    .foregroundColor(.yellow)
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .clipShape(Circle())
            })
            .padding(.trailing, -5)
            Button(action: {}, label: {
                Image(systemName: "phone.fill")
                    .foregroundColor(.yellow)
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .clipShape(Circle())
            })
        }
        .padding(.horizontal)
    }
}

struct ItemWwq: Identifiable {
    let id = UUID().uuidString
    let name: String
    let desc: String
    var image: String
}

// Model Data
var itemsData = [
    ItemWwq(name: "iJustine", desc: "5 Miles Away", image: "1"),
    ItemWwq(name: "Kaviya", desc: "0.5 Miles Away", image: "2"),
    ItemWwq(name: "Anna", desc: "3 Miles Away", image: "3"),
    ItemWwq(name: "Steve", desc: "4 Miles Away", image: "4"),
    ItemWwq(name: "Jenna", desc: "10 Miles Away", image: "5"),
    ItemWwq(name: "Creg", desc: "1 Miles Away", image: "1"),
    ItemWwq(name: "Tom Land", desc: "0.5 Miles Away", image: "2"),
    ItemWwq(name: "Anna", desc: "3 Miles Away", image: "3"),
    ItemWwq(name: "Steve", desc: "4 Miles Away", image: "4"),
    ItemWwq(name: "jenna", desc: "1 Miles Away", image: "5"),
    ItemWwq(name: "哇咔咔", desc: "1 Miles Away", image: "5"),
    ItemWwq(name: "Creg", desc: "1 Miles Away", image: "1"),
    ItemWwq(name: "Tom Land", desc: "0.5 Miles Away", image: "2"),
    ItemWwq(name: "Anna", desc: "3 Miles Away", image: "3"),
    ItemWwq(name: "Steve", desc: "4 Miles Away", image: "4"),
    ItemWwq(name: "jenna", desc: "1 Miles Away", image: "5"),
    ItemWwq(name: "Steve", desc: "4 Miles Away", image: "4"),
    ItemWwq(name: "Jenna", desc: "10 Miles Away", image: "5"),
    ItemWwq(name: "Creg", desc: "1 Miles Away", image: "1"),
    ItemWwq(name: "Tom Land", desc: "0.5 Miles Away", image: "2"),
    ItemWwq(name: "Anna", desc: "3 Miles Away", image: "3"),
    ItemWwq(name: "Steve", desc: "4 Miles Away", image: "4"),
    ItemWwq(name: "jenna", desc: "1 Miles Away", image: "5"),
    ItemWwq(name: "Creg", desc: "1 Miles Away", image: "1"),
]

