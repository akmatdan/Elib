//
//  LoginViewModel.swift
//  Elib
//
//  Created by Daniil Akmatov on 12/3/22.
//

import Foundation
import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    // Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    
    @Published var signedIn = false
    
    let auth = Auth.auth()
    
    // Log Status
    @AppStorage("Log_Status") var log_Status: Bool = false
    
    //Login Call
    func Login() {
        withAnimation {
            auth.signIn(withEmail: email,
                        password: password) { [weak self] result, error in
               guard result != nil, error == nil else  {
                    return
                }
                DispatchQueue.main.async {
                    self?.signedIn = true
                }
            }
        }
    }
    
    func Register() {
        withAnimation {
            auth.createUser(withEmail: email, password: password) { [weak self] result, error in
                guard result != nil, error == nil else  {
                     return
                 }
                DispatchQueue.main.async {
                    self?.signedIn = true
                }
            }
        }
    }
    
    func ForgotPassword() {
        
    }
    
    func isSignedIn() -> Bool? {
        return auth.currentUser != nil
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
        
    }
}
