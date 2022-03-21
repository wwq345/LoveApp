//
//  UIApplicationExtension.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/11.
//

import UIKit

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
