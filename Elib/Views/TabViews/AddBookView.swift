//
//  AddBookView.swift
//  Elib
//
//  Created by Daniil Akmatov on 25/3/22.
//

import SwiftUI
import FirebaseStorage

struct AddBookView: View {
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    
    @ObservedObject var model = BooksViewModel()
    
    @State var isbn = ""
    @State var title = ""
    @State var author = ""
    @State var year = ""
    @State var description = ""
    
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                
               VStack {
                   
                   if selectedImage != nil {
                       Image(uiImage: selectedImage!)
                           .resizable()
                           .frame(width: 200, height: 200)
                   }
                   
                    Button {
                        isPickerShowing = true
                    } label: {
                        VStack {
                            Image(systemName: "plus.square")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Color(.red))
                            Text("Select a Photo")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                    // Image picker
                    ImagePicker(selectedImage: $selectedImage, isPickerShowign: $isPickerShowing )
                }
                    
                VStack(spacing: 10) {
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
                    
                    if selectedImage != nil {
                        Button {
                            model.addData(isbn: isbn, title: title, author: author, year: year, description: description)
                            uploadPhoto()
                        } label: {
                            Text("Add Book")
                                .font(.custom(customFont, size: 17).bold())
                                .fontWeight(.semibold)
                                .padding(.vertical, 20)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                                .background(Color(red: 0.2, green: 0.0, blue: 0.7))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        }
                    }
                }
                    
                Button(action: {
                    self.isEditing = false
                    selectedImage = nil
                    isbn = ""
                    title = ""
                    author = ""
                    year = ""
                    description = ""
                    UIApplication.shared.dismissKeyboard()
                },
                       label: {
                    Text("Cancel")
                        .font(.custom(customFont, size: 17).bold())
                        .fontWeight(.semibold)
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(Color(red: 0.2, green: 0.0, blue: 0.7))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                })
            }
        }
        .hiddenNavigationBarStyle()
        .padding(30)
        .background(Color(.systemGray6))
    }
    
    func uploadPhoto() {
        
        // Make sure that the selected image isn't nil
        guard selectedImage != nil else { return }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
         
        // Turn our image into data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        // Check that we were able to convert it to data
        guard imageData != nil else { return }
        
        // Specify the file path and name
        let fileRef = storageRef.child("booksImages/\(UUID().uuidString).jpg")
        
        // Upload that data
        let uploadImage = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            // Check for error
            if error == nil && metadata != nil {
                
                // TODO: Save a reference to the file in Firestore DB
                
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}