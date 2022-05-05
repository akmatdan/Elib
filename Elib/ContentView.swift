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
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                if self.status {
                    
                    TabBar()
                    
                } else {
                    ZStack {
                        NavigationLink(destination: SignUpView(show: self.$show), isActive: self.$show) {
                            Text("")
                        }
                        .hidden()
                        
                        LogInView(show: self.$show)
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
