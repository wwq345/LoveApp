//
//  TestLogin.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/3/11.
//

import SwiftUI

struct TestLogin: View {
    @StateObject private var loginVm = TestLoginViewModel()
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        VStack{
            Text("Secure App")
                .font(.largeTitle)
            TextField("Email Address",text: $loginVm.credentials.email)
                .keyboardType(.emailAddress)
            
           SecureField("password",text: $loginVm.credentials.password)
           
            if loginVm.showProgressView{
                //what's this
                ProgressView()
            }
            
            Button("Login"){
                loginVm.login { success in
                    authentication.updateValidation(success: success)
                }
            }
            .disabled(loginVm.loginDisabled)
            .padding(.bottom, 20)
            
            Image("dogSign")
                .resizable()
                .imageScale(.small)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            
            Spacer()
            
        }
        .textInputAutocapitalization(.none)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
        .disabled(loginVm.showProgressView)
        .alert(item: $loginVm.error) { error in
            Alert(title: Text("Invalid"), message: Text(error.localizedDescription))
        }
    }
}

struct TestLogin_Previews: PreviewProvider {
    static var previews: some View {
        TestLogin()
            .environmentObject(Authentication())
    }
}
