//
//  GanreList.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI

struct GanreList: View {
    var body: some View {
    
        ScrollView(.vertical, showsIndicators: false) {
            VStack() {
                // Custom Navigation Links
                CustomNavigationLink(title: "g1") {
                    Text("")
                        .navigationTitle("g1")
                        .background(Color(.systemGray6))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                CustomNavigationLink(title: "g2") {
                    Text("")
                        .navigationTitle("g2")
                        .background(Color(.systemGray6))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                CustomNavigationLink(title: "g3") {
                    Text("")
                        .navigationTitle("g3")
                        .background(Color(.systemGray6))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                CustomNavigationLink(title: "g4") {
                    Text("")
                        .navigationTitle("g4")
                        .background(Color(.systemGray6))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                CustomNavigationLink(title: "g5") {
                    Text("")
                        .navigationTitle("g5")
                        .background(Color(.systemGray6))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                CustomNavigationLink(title: "g6") {
                    Text("")
                        .navigationTitle("g6")
                        .background(Color(.systemGray6))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                CustomNavigationLink(title: "g7") {
                    Text("")
                        .navigationTitle("g7")
                        .background(Color(.systemGray6))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 22)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        
        
        .background(Color(.systemGray6))
    }
    
    // Avoiding new structs
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping () -> Detail) -> some View {
        NavigationLink {
            content()
        } label: {
            HStack {
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }
    }
}

struct GanreList_Previews: PreviewProvider {
    static var previews: some View {
        GanreList()
    }
}
