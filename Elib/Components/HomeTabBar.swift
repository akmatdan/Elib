//
//  BodyHomeView.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI

struct HomeTabBar: View {
    
    @State var selectedIndex = 1
    @State var shouldShowModel = false
    
    let tabBarImageNames = ["Ganre", "Books to read", "Libraries"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                ForEach(0..<3) {num in
                    Button(action: {
                        selectedIndex = num
                    }, label: {
                        Spacer()
                            Text("\(tabBarImageNames[num])")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.7))
                        
                        Spacer()
                    })
                }
            }
            Spacer()
            Divider()
                .padding(.top, 8)
            Spacer()
            
            ZStack {
                
                switch selectedIndex {
                case 0:
                    GanreList()
                    
                case 1:
                    MainList()
                    
                default:
                    LibrariesList()
                }
            }
        }
    }
}

struct HomeTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabBar()
    }
}

