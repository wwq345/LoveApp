//
//  LoginView.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/2/23.
//

import SwiftUI
//import FireBase

struct LoginView: View {
    
    @State var isFocused: Bool = false
    @State var isLoading: Bool = false
    @State var isAlert: Bool = false
    @State var isSuccess: Bool = false
    @EnvironmentObject var userStore: UserStore
    
    var errorMessage: String = "There are some Problem with Logging"

    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack(alignment: .top){

                
                Color("Color11")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                
                titleView()
                
                LoadOnTextFieldView(isFocused: self.$isFocused)
                
                
            
                if !self.isFocused{
                    FunctionButtonView(isLoading: self.$isLoading, isAlert: self.$isAlert, isSuccess: self.$isSuccess, userStore: .constant(self.userStore))
                }
                
                if self.isLoading{
                    LoginLoadingView()
                }
                
                
                if self.isSuccess{
                    LoginSuccessView()
                        
                }
                
            }
//            .offset(y:self.isFocused ? -300 : 0)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserStore())
    }
}

struct titleView: View {
    
    @State var ifSpin: Bool = false
    @State var dragPosition: CGSize = .zero
    @State var ifDragging : Bool = false
    
    var body: some View {
        VStack {
            GeometryReader{ geometry in
                Text("Come with us and Find your own Love!!!")
                    .font(.system(size: geometry.size.width / 10, weight: .bold))
                    .foregroundColor(Color("Color10"))
                
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .padding(.horizontal, 16)
            .offset(x: self.dragPosition.width / 15, y: self.dragPosition.height / 15)
            
            
            Text("Everyone here can tell truth,trust each other and be brave to love")
                .font(.subheadline)
                .frame(width: 250)
                .foregroundColor(Color.white)
                .offset(x: self.dragPosition.width / 20, y: self.dragPosition.height / 20)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top, 66)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image("Blob")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: self.ifSpin ? 360+90 : 90))
                    .blendMode(.plusDarker)
//                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false), value: self.ifSpin)
                    .onAppear(){
                        self.ifSpin = true
                    }
                
                Image("Blob")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(x: -200, y: -250)
                    .rotationEffect(Angle(degrees: self.ifSpin ? 360 : 0), anchor: .leading)
                    .blendMode(.overlay)
//                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false), value: self.ifSpin)
            }
        )
        .background(
            Image("poety")
                .resizable()
                .frame(maxWidth: screen.width)
                .frame(height: 320)
                .aspectRatio(contentMode: .fill)
//                                .blendMode(.hardLight)
                .offset(x: self.dragPosition.width / 20, y: self.dragPosition.height / 20)
            ,
            alignment: .bottom
        )
        .background(Color("Color13"))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(self.ifDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8),value: self.ifDragging)
        .rotation3DEffect(Angle(degrees: 5), axis: (x: self.dragPosition.width, y: self.dragPosition.height, z: 0))
        .gesture(
            DragGesture().onChanged(){ value in
                self.dragPosition = value.translation
                self.ifDragging = true
            }
                .onEnded(){ value in
                    self.dragPosition = .zero
                    self.ifDragging = false
                }
        )
    }
}

struct LoadOnTextFieldView: View {
    @State var email = ""
    @State var password = ""
    @Binding var isFocused: Bool
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(Color("Color12"))
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.gray, radius: 10, x: 0, y: 5)
                    .padding(.leading)
                
                
                TextField("Email or your Phone Number", text: self.$email)
                    .keyboardType(.emailAddress)
                //                        .background(Color.orange)
                    .font(.subheadline)
                    .padding([.leading,.trailing])
                    .frame(height: 44)
                
            }
            .onTapGesture {
                self.isFocused = true
            }
            
            Divider()
                .padding(.leading)
            
            HStack {
                
                Image(systemName: "lock.fill")
                    .foregroundColor(Color("Color12"))
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.gray, radius: 10, x: 0, y: 5)
                    .padding(.leading)
                
                
                SecureField("Password", text: self.$password)
                    .keyboardType(.default)
                //                        .background(Color.orange)
                    .font(.subheadline)
                    .padding([.leading,.trailing])
                    .frame(height: 44)
                
            }
            .onTapGesture {
                self.isFocused = true
            }
            
        }
        .frame(height: 136)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.6).blur(radius:20))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.gray, radius: 20, x: 0, y: 10)
        .offset(y: 460)
    }
}

struct FunctionButtonView: View{
    @Binding var isLoading: Bool
    @Binding var isAlert: Bool
    @Binding var isSuccess: Bool
    @Binding var userStore: UserStore
    var errorMessage: String = "There are some Problem with Logging"
    var forgetMessage: String = "Too Stupid to forget these"
    
    func login(){
        self.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.isSuccess = true
            self.userStore.isLogged = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isSuccess = false
                self.userStore.showLogin = false
            }
        }
        
//        Auth.auth().signin(withEmail: self.email password: self.password ){
//            (result, error) in
//            self.isLaoding = false
//            if error != nil{
//                self.alertMessage = ValidationError.invalidValue ?? ""
//                self.isAlert = true
//            }else{
//                self.isSuccess = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                    self.isSuccess = false
//                    self.email = ""
//                    self.password = ""
//                }
//            }
//
//        }
        
    }
    
    var body: some View{
        HStack{
            Button(action: {
                self.isAlert = true
            }) {
                Text("Forget Password or count?")
            }
            .padding(.horizontal, 30)
            .background(Color("Color5"))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color("Color5"), radius: 10, x: 0, y: 10)
            .alert(isPresented: self.$isAlert) {
                Alert(title: Text("Stupid!"), message: Text(self.forgetMessage), dismissButton: .default(Text("I know")))
            }
            
            Spacer()
            
            Button(action: {
                self.login()
            }){
                Text("Log In")
            }
            .padding(12)
            .padding(.horizontal, 30)
            .background(Color("Color3"))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color("Color3"), radius: 10, x: 0, y: 10)
            .alert(isPresented: self.$isAlert){
                Alert(title: Text("Error"), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .padding()
        
    }
}


//struct ValidationSevice{
//    func validateUsername(_ username: String?) throws -> String{
//        guard let username = username else{
//            throw ValidationError.invalidValue
//        }
//        guard username.count > 3 else{ throw
//            ValidationError.usernameTooShort
//        }
//        guard username.count < 20 else{
//            throw ValidationError.usernameTooLong
//        }
//        return username
//    }
//
//    func validatePassword(_ password: String?) throws -> String{
//        guard let password = password else{
//            throw ValidationError.invalidValue
//        }
//        guard password.count > 8 else{ throw
//            ValidationError.passwordTooShort
//        }
//        guard password.count < 20 else{
//            throw ValidationError.passwordTooLong
//        }
//        return password
//    }
//}
//
//enum ValidationError: LocalizedError{
//    case invalidValue
//    case passwordTooLong
//    case passwordTooShort
//    case usernameTooLong
//    case usernameTooShort
//
//    var errorDescription: String?{
//        switch self {
//        case .invalidValue:
//            return "invalid value"
//        case .passwordTooLong:
//            return "pwd too long"
//        case .passwordTooShort:
//            return "pwd too short"
//        case .usernameTooLong:
//            return "unm too long"
//        case .usernameTooShort:
//            return "unm too short"
//        }
//    }
//}
