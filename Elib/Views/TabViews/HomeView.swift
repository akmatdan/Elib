//
//  HomeView.swift
//  Elib
//
//  Created by Daniil Akmatov on 29/3/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchText = ""
    
    @Namespace var animation
    @ObservedObject var model = BooksViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                ZStack {
                    if model.searchActivated {
                        SearchBar(searchText: $searchText)
                    } else {
                        SearchBar(searchText: $searchText)
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                
                HomeTabBar()
            }
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
