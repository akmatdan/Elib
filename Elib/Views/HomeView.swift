//
//  HomeView.swift
//  Elib
//
//  Created by Daniil Akmatov on 1/3/22.
//

import SwiftUI
import Foundation

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    HStack {
                        Text("HomeView")
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
