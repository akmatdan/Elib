//
//  TabBar.swift
//  Elib
//
//  Created by Daniil Akmatov on 28/2/22.
//

import SwiftUI

struct TabBar: View {
    
    @State var selectedIndex = 0
    
    let tabBarImageNames = ["house", "magnifyingglass", "plus.square.fill", "book", "person"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                
                Spacer()
                switch selectedIndex {
                case 0:
                    HomeTabBar()
                    
                case 1:
                    SearchBooksView()
                
                case 2:
                    AddBookView()
                    
                case 3:
                    MyLibraryView()

                default:
                    ProfileView()
                }
            }
            
            Divider()
                .padding(.bottom, 8)
            
            HStack {
                ForEach(0..<5) {num in
                    Button(action: {
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        
                        if num == 2 {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Color(.red))

                        } else {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(red: 0.2, green: 0.0, blue: 0.7) : .init(white: 0.7))
                        }
                        Spacer()
                    })
                }
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
