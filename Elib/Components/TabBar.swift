//
//  TabBar.swift
//  Elib
//
//  Created by Daniil Akmatov on 28/2/22.
//

import SwiftUI

struct TabBar: View {
    
    @State var currentTab: Tab = .Home
    @StateObject var data: BooksViewModel = BooksViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack {
            TabView(selection: $currentTab) {
                
                HomeView()
                    .tag(Tab.Home)
                
                SearchBooksView()
                    .tag(Tab.Search)
                
                AddBookView()
                    .tag(Tab.AddBook)
                
                MyLibraryView()
                    .environmentObject(data)
                    .tag(Tab.MyLibrary)
                
                ProfileView()
                    .tag(Tab.Profile)
            }
            
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    
                    Button {
                        currentTab = tab
                    } label: {
                        
                        Image(systemName: tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                        // Shadow at bg
                            .background(
                                Color(red: 0.2, green: 0.0, blue: 0.7)
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                // Bluring
                                    .blur(radius: 5)
                                // Making little big
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color(red: 0.2, green: 0.0, blue: 0.7) : Color.black.opacity(0.3))
                    }

                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 5)
        }
    }
}

// Tab cases, Iterable
enum Tab: String, CaseIterable {
    
    // Raw Value Image name in asset
    case Home = "books.vertical.fill"

    case Search = "magnifyingglass"

    case AddBook = "plus.square.fill"

    case MyLibrary = "book.fill"

    case Profile = "slider.vertical.3"
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
