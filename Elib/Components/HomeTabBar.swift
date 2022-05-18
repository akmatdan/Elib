//
//  BodyHomeView.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI

struct HomeTabBar: View {

    @State var selectedIndex = 0
    
    let tabBarImageNames = ["Books", "Ganre"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // SelectedIndex of TabBar
                HStack {
                    ForEach(0..<2) { num in
                        Button(action: {
                            selectedIndex = num
                        }, label: {
                            Spacer()
                                Text("\(tabBarImageNames[num])")
                                    .font(.custom(customFont, size: 16))
                                    .fontWeight(.bold)
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
                ZStack {
                    
                    switch selectedIndex {
                    case 0:
                        MainList()
                    default:
                        GanreList()
                    }
                }
                Spacer()
            }
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
    }
}

struct HomeTabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

