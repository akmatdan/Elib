//
//  TabBar.swift
//  Elib
//
//  Created by Daniil Akmatov on 28/2/22.
//

import SwiftUI

struct TabBar: View {
    
    @State var selectedIndex = 0
    @State var shouldShowModel = false
    
    let tabBarImageNames = ["house", "magnifyingglass", "plus.square.fill", "book", "person"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModel, content: {
                        Button(action: {shouldShowModel.toggle()}, label: {
                            Text("Cancel")
                                
                        })
                    })
                    
                
                switch selectedIndex {
                case 0:
                    HomeView()
                    
                case 1:
                    SearchBooksView()
                    
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
                        
                        if num == 2 {
                            shouldShowModel.toggle()
                            return
                        }
                        
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
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.7))
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
