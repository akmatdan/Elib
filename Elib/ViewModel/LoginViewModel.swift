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
    
    @Published var signedIn: Bool = false
    
    @Published var loginStatusMessage = ""
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    //Login Call
    func Login(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, err in
            guard result != nil, err == nil else  {
                print("Faild to login user: ", err as Any)
                self?.loginStatusMessage = "Faild to login user: \(String(describing: err))"
                return
            }
            DispatchQueue.main.async {
                print("Successfully login user: \(result?.user.uid ?? "" )")
                self?.signedIn = true
                self?.loginStatusMessage = "Successfully login user: \(result?.user.uid ?? "" )"
            }
        }
    }
    
    func Register() {
        withAnimation {
            auth.createUser(withEmail: email, password: password) { [weak self] result, err in
                guard result != nil, err == nil else  {
                    print("Faild to create user: ", err as Any)
                    self?.loginStatusMessage = "Faild to create user: \(String(describing: err))"
                    return
                }
                DispatchQueue.main.async {
                    print("Successfully created user: \(result?.user.uid ?? "" )")
                    self?.signedIn = true
                    self?.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "" )"
                }
            }
        }
    }
    
    func ForgotPassword() {
        
    }
    
    func signOut() {
        try? auth.signOut()
        UserDefaults.standard.set(false, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
    }
}
