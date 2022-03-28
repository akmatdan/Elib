//
//  LoginViewModel.swift
//  Elib
//
//  Created by Daniil Akmatov on 12/3/22.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    // Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    
    
    // Log Status
    @AppStorage("Log_Status") var log_Status: Bool = false
    
    //Login Call
    func Login() {
        withAnimation {
            log_Status = true
        }
    }
    
    func Register() {
        withAnimation {
            log_Status = true
        }
    }
    
    func ForgotPassword() {
        
    }
}
