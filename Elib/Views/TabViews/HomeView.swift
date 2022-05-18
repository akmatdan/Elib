//
//  HomeView.swift
//  Elib
//
//  Created by Daniil Akmatov on 29/3/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeData: BooksViewModel = BooksViewModel()
    
    var body: some View {
        NavigationView{
            VStack {

                MainList()
//                HomeTabBar()
                
            }
            .background(Color(.systemGray6))
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
