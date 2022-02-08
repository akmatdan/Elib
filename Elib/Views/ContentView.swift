//
//  ContentView.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.
//

import SwiftUI

// HomeView
struct ContentView: View {
    
    var body: some View {
        
        VStack {
            BookListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
