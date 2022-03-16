//
//  Authentication.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/11.
//

import Foundation
import SwiftUI

class Authentication: ObservableObject{
    @Published var isValidated = false
    
    enum AuthenicationError: Error, LocalizedError, Identifiable{
        case invalidCredentials
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String?{
            switch self{
            case .invalidCredentials:
                return NSLocalizedString("You idiot forget your passord,hhh!!", comment: "")
            }
        }
        
    }
    
    func updateValidation(success: Bool){
        withAnimation {
            isValidated = success
        }
    }
}
