//
//  LoginView.swift
//  Elib
//
//  Created by Daniil Akmatov on 11/3/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginData: LoginViewModel = LoginViewModel()
    
    var body: some View {
        
        VStack {
            
            Text("Welcome \nback")
                .font(.custom(customFont, size: 55).bold())
                .frame(height: getRect().height / 3.5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.white)
                .padding()
                .background(
                
                    ZStack {
                        
                        LinearGradient(colors: [
                            Color(red: 0.5, green: 0.1, blue: 0.7),
                            Color("LoginCircle")
                                .opacity(0.8),
                        ], startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading, 30)
                    }
                )
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15) {
                    Text(loginData.registerUser ? "Register" : "Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Email Field
                    CustomTextField(icon: "envelope", title: "Email", hint: "abcde@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    // Password Field
                    CustomTextField(icon: "lock", title: "Password", hint: "12345", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    // Register reenter password
                    if loginData.registerUser{
                        CustomTextField(icon: "envelope", title: "Re-Enter Password", hint: "123456", value: $loginData.reEnterPassword, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    
                    // Forgot Password Button
                    Button {
                        loginData.ForgotPassword()
                    } label: {
                        Text("Forgot password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.2, green: 0.0, blue: 0.7))
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity)
                    
                    // Login Button
                    Button {
                        guard !loginData.email.isEmpty, !loginData.password.isEmpty else { return }
                        if loginData.registerUser {
                            loginData.Register()
                        } else {
                            loginData.Login()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Register" : "Login")
                            .font(.custom(customFont, size: 17).bold())
                            .fontWeight(.semibold)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color(red: 0.2, green: 0.0, blue: 0.7))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                    // Register Button
                    Button {
                        withAnimation {
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Back to login" : "Create account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.2, green: 0.0, blue: 0.7))
                    }
                    .padding(.top, 8)
                    
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
            .ignoresSafeArea()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.2, green: 0.0, blue: 0.7))
        
        // Clearing data when changes
        .onChange(of: loginData.registerUser) { newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.reEnterPassword = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
            
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 3)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 3)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Show Button for password Fieeld
        .overlay(
            
            Group {
                
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color(red: 0.2, green: 0.0, blue: 0.7))
                    })
                        .offset(y: 8)
                }
            }
            ,alignment: .trailing
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
