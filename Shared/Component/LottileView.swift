//
//  LottileView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/1.
//

import SwiftUI
import Lottie

struct LottileView: UIViewRepresentable{
    
    var name: String = " "
    
    typealias UIViewType = UIView
    
    func makeUIView(context:  UIViewRepresentableContext<LottileView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(self.name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottileView>) {
        
    }
    
    
    
    
}
