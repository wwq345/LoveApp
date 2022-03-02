//
//  TestPostView.swift
//  wang.dov
//
//  Created by i564206 on 2022/2/22.
//

import SwiftUI

struct TestPostView: View {
    
    @ObservedObject var dataStore = PostDataStore()
    
    var body: some View {
        List(dataStore.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title)
                    .font(.system(.title, design: .serif)).bold()
                Text(post.body)
                    .font(.subheadline).foregroundColor(.secondary)
            }
        }
    }
}

struct TestPostView_Previews: PreviewProvider {
    static var previews: some View {
        TestPostView()
    }
}
