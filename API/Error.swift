//
//  Error.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/11.
//

import Foundation

class ErrorMayHave: ObservableObject{
    
    func validateUsername(_ username: String?) throws{
        guard let username = username else{
            throw ValidationError.invalidValue
        }
        guard username.count > 3 else{ throw
            ValidationError.usernameTooShort
        }
        guard username.count < 20 else{
            throw ValidationError.usernameTooLong
        }
    }

    func validatePassword(_ password: String?) throws{
        guard let password = password else{
            throw ValidationError.invalidValue
        }
        guard password.count > 8 else{ throw
            ValidationError.passwordTooShort
        }
        guard password.count < 20 else{
            throw ValidationError.passwordTooLong
        }
    }
    
    enum ValidationError: Error, LocalizedError{
        case invalidValue
        case passwordTooLong
        case passwordTooShort
        case usernameTooLong
        case usernameTooShort

        var errorDescription: String?{
            switch self {
            case .invalidValue:
                return "invalid value"
            case .passwordTooLong:
                return "pwd too long"
            case .passwordTooShort:
                return "pwd too short"
            case .usernameTooLong:
                return "unm too long"
            case .usernameTooShort:
                return "unm too short"
            }
        }
    }

    enum LoginError: Error, LocalizedError{
        case userNotFound
        case passwordWrong
        
        var  errorDescription: String?{
            switch self{
            case .passwordWrong:
                return "Your password not right"
            case .userNotFound:
                return "User not registered"
            }
        }
    }

    enum RegisterError: Error, LocalizedError{
        case userNameDuplicated
        case unKnownRegisterError
        
        var errorDescription: String?{
            switch self{
            case .unKnownRegisterError:
                return "unknown error"
            case .userNameDuplicated:
                return "User had been registered"
            }
        }
    }

}
