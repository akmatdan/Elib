//
//  SearchBar.swift
//  Elib
//
//  Created by Daniil Akmatov on 7/2/22.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    @State private var isEditing = false
    
    var body: some View {
        
        HStack (spacing: 15) {
            TextField("Search ...", text: $searchText)
                .font(.custom(customFont, size: 14))
                .padding(10)
                .padding(.horizontal, 35)
                .background(Color(.white))
                .foregroundColor(.black)
                .cornerRadius(8)
                .overlay(
                    
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
                        }
                    }
                ).onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    searchText = ""
                    UIApplication.shared.dismissKeyboard()
                }) {
                    Text("Cancel")
                        .font(.custom(customFont, size: 14).bold())
                        .foregroundColor(Color(.systemGray2))
            }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default, value: true)
            }
        }
        .padding()
        .navigationBarHidden(true)
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
