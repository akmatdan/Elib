//
//  ContentView.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.
//

import SwiftUI

// HomeView
struct ContentView: View {
    
    // Log status
    @StateObject var loginData: LoginViewModel = LoginViewModel()
    
    var body: some View {
        
        Group {
            if loginData.signedIn {
                TabBar()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
