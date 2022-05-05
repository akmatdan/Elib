//
//  LoginView.swift
//  Elib
//
//  Created by Daniil Akmatov on 11/3/22.
//

import SwiftUI
import Firebase

struct LogInView: View {
    
    @StateObject var loginData: LoginViewModel = LoginViewModel()
    
    @State var color = Color("Purple")
    @State var visible = false
    @State var alert = false
    @State var error = ""
    
    @Binding var show : Bool
    
    
    var body: some View {
        
        ZStack {
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader { _ in
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Image("flogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 300)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                                .offset(x: 20)
                            
                            Text("Log in")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(color)
                            
                            TextField("Email", text: $loginData.email)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(loginData.email != "" ? color : Color.gray, lineWidth: 2))
                                .padding(.top, 25)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            
                            HStack {
                                VStack {
                                    if self.visible {
                                        TextField("Password", text: $loginData.password)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    else {
                                        SecureField("Password", text: $loginData.password)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                }
                                Button {
                                    self.visible.toggle()
                                } label: {
                                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.gray)
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(loginData.password != "" ? color : Color.gray, lineWidth: 2))
                            .padding(.top, 25)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                    self.reset()
                                } label: {
                                    Text("Forget password")
                                        .fontWeight(.bold)
                                        .foregroundColor(color)
                                }
                            }
                            .padding(.top, 20)
                            
                            Button {
                                self.verify()
                            } label: {
                                Text("Log in")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(color)
                            .cornerRadius(10)
                            .padding(.top, 25)
                            
                        }
                        .padding(.horizontal, 25)
                    }
                }
                
                Button {
                    self.show.toggle()
                } label: {
                    Text("Register")
                        .fontWeight(.bold)
                        .foregroundColor(color)
                }
                .padding()
            }
            
            if self.alert {
                
                ZStack(alignment: .center) {
                    
                    ErrorView(alert: self.$alert, error: self.$error)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func verify() {
        
        if self.loginData.email != "" && self.loginData.password != "" {
            Auth.auth().signIn(withEmail: loginData.email, password: loginData.password) { res, err in
                
                if err != nil {
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                print("Success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
    func reset() {
        
        if loginData.email != "" {
            Auth.auth().sendPasswordReset(withEmail: loginData.email) { err in
                
                if err != nil {
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "RESET"
                self.alert.toggle()
            }
        } else {
            
            self.error = "Email Id is empty"
            self.alert.toggle()
        }
    }
}

struct SignUpView: View {
    
    @StateObject var loginData: LoginViewModel = LoginViewModel()
    
    @Binding var show : Bool
    
    @State var color = Color("Purple")
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack(alignment: .topLeading) {
                GeometryReader { _ in
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Image("flogo2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 300)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                                .offset(x: 20)
                            
                            Text("Sign up")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(color)
                            
                            TextField("Email", text: $loginData.email)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(loginData.email != "" ? color : Color.gray, lineWidth: 2))
                                .padding(.top, 25)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            
                            HStack {
                                VStack {
                                    if loginData.showPassword {
                                        TextField("Password", text: $loginData.password)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    else {
                                        SecureField("Password", text: $loginData.password)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                }
                                Button {
                                    loginData.showPassword.toggle()
                                } label: {
                                    Image(systemName: loginData.showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.gray)
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(loginData.password != "" ? color : Color.gray, lineWidth: 2))
                            .padding(.top, 25)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            
                            HStack {
                                VStack {
                                    if loginData.showReEnterPassword {
                                        TextField("Re-enter", text: $loginData.reEnterPassword)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                    else {
                                        SecureField("Re-enter", text: $loginData.reEnterPassword)
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                    }
                                }
                                Button {
                                    loginData.showReEnterPassword.toggle()
                                } label: {
                                    Image(systemName: loginData.showReEnterPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(Color.gray)
                                }
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(loginData.reEnterPassword != "" ? color : Color.gray, lineWidth: 2))
                            .padding(.top, 25)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            
                            Button {
                                self.register()
                            } label: {
                                Text("Register")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 50)
                            }
                            .background(color)
                            .cornerRadius(10)
                            .padding(.top, 25)
                            
                        }
                        .padding(.horizontal, 25)
                    }
                }
                
                Button {
                    self.show.toggle()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(color)
                }
                .padding()
            }
            
            if self.alert {
                ZStack(alignment: .center) {
                    ErrorView(alert: self.$alert, error: self.$error)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func register() {
        
        if loginData.email != "" {
            
            if loginData.password == loginData.reEnterPassword {
                
                Auth.auth().createUser(withEmail: loginData.email, password: loginData.password) { res, err in
                    
                    if err != nil {
                        
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    print("Success")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
                
            } else {
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
}

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body: some View {
        
        GeometryReader { _ in
            
            VStack {
                
                HStack {
                    Text(self.error == "RESET" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                Button {
                    self.alert.toggle()
                } label: {
                    Text(self.error == "RESET" ? "OK" : "Cancel")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color("Purple"))
                .cornerRadius(10)
                .padding(.top, 25)
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
        }
        .padding(.vertical, 200)
        .padding(.horizontal, 35)
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
