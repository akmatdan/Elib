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
    @State var isPickerShowing = false
    
    @ObservedObject var model = BooksViewModel()
    @State var isbn = ""
    @State var title = ""
    @State var author = ""
    @State var year = ""
    @State var description = ""
    
    let tabBarImageNames = ["house", "magnifyingglass", "plus.square.fill", "book", "person"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModel, content: {
                        
                        VStack {
                            Button {
                                isPickerShowing = true
                            } label: {
                                Text("Select a photo")
                            }
                        }
                        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                            // Image picker
                            ImagePicker()
                        }
                        
                        VStack(spacing: 5) {
                            

                            TextField("ISBN", text: $isbn)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("title", text: $title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("author", text: $author)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("year", text: $year)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("description", text: $description)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button {
                                model.addData(isbn: isbn, title: title, author: author, year: year, description: description)
                            } label: {
                                Text("Add Book")
                            }
                        }.padding()
                        
                        Button(action: {shouldShowModel.toggle()},
                               label: {
                            Text("Cancel")
                        })
                        
                    })
                
                switch selectedIndex {
                case 0:
                    HomeTabBar()
                    
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
                                .foregroundColor(selectedIndex == num ? Color(red: 0.2, green: 0.0, blue: 0.7) : .init(white: 0.7))
                        }
                        
                        Spacer()
                    })
                }
            }
        }.background(Color.white)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
