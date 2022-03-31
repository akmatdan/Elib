//
//  MainList.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI

struct MainList: View {
    
    @Namespace var animation
    // Shared Data
    @EnvironmentObject var sharedData: SharedDataModel
    @StateObject var homeData: BooksViewModel = BooksViewModel()
    
    
    var body: some View {
        
        VStack() {
            
            BookCardView()
            Spacer()
        }
    }
}
