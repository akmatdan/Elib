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
    func ForgotPassword() {
        
    }
    
    func signOut() {
        try? auth.signOut()
        UserDefaults.standard.set(false, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
    }
}
