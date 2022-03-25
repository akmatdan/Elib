//
//  BodyHomeView.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI

struct HomeTabBar: View {
    
    @State var searchText = ""
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
                                .foregroundColor(selectedIndex == num ? Color(red: 0.2, green: 0.0, blue: 0.7) : .init(white: 0.7))
                                .padding(.bottom, 10)
                                .overlay(
                                    ZStack {
                                        if selectedIndex == num {
                                            Capsule()
                                                .fill(Color(red: 0.2, green: 0.0, blue: 0.7))
                                                .frame(height: 2)
                                        }
                                    }
                                        ,alignment: .bottom
                                )
                        Spacer()
                    })
                }
            }
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
        }.background(Color.white)
    }
}

struct HomeTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabBar()
    }
}

