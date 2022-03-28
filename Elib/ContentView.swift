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
    @AppStorage("Log_Status") var log_Status: Bool = false
    
    var body: some View {
        
        Group {
            if log_Status{
                TabBar()
            } else {
                OnBoardingView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
