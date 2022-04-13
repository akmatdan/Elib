//
//  AddBookView.swift
//  Elib
//
//  Created by Daniil Akmatov on 25/3/22.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

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
    
    @State var retrivedImages = [UIImage]()
    
    @State var customAlert = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                
                // Select and Change Button
                VStack {
                   
                   if selectedImage != nil {
                       Image(uiImage: selectedImage!)
                           .resizable()
                           .frame(maxWidth: 240, maxHeight: 320)
                   }
                   
                    Button {
                        isPickerShowing = true
                    } label: {
                        if selectedImage != nil {
                            Text("Change a photo")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color.gray)
                                .padding(.bottom, 20)
                        } else {
                            VStack(spacing: 20) {
                                Image(systemName: "photo.fill")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(Color(.gray))
                                    .padding(.top, 10)
                                
                                Text("Select a photo")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(Color.gray)
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                }
                    
                // TextFields
                VStack(spacing: 15) {
                    TextField("ISBN", text: $isbn)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Author", text: $author)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Year", text: $year)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    // Add Book button
                    if selectedImage != nil  {
                        
                        Button {
                            withAnimation {
                                customAlert.toggle()
                            }
                            
                            uploadPhoto()
                            
                            self.isEditing = false
                            selectedImage = nil
                            isbn = ""
                            title = ""
                            author = ""
                            year = ""
                            description = ""
                            UIApplication.shared.dismissKeyboard()
                            
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
                }.sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                    
                    // Image picker
                    ImagePicker(selectedImage: $selectedImage, isPickerShowign: $isPickerShowing )
                }
                
                // Cancel button
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
                        .padding(.vertical, 10)
                })
            }
            .background(Color(.systemGray6))
            .padding(.horizontal, 30)
            
            if customAlert {
                CustomAlertView(show: $customAlert)
            }
                
        }
        .navigationBarHidden(true)
        
        .background(Color(.systemGray6))
    }
    
    // Uploading Photo and Data
    func uploadPhoto() {
        
        // Make sure that the selected image isn't nil
        guard selectedImage != nil else { return }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
         
        // Turn our image into data
        let imageData = selectedImage!.jpegData(compressionQuality: 1)
        
        // Check that we were able to convert it to data
        guard imageData != nil else { return }
        
        // Specify the file path and name
        let path = "\(UUID().uuidString).jpeg"
        let fileRef = storageRef.child(path)
        
        // Upload that data
        let uploadImage = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            // Check for error
            if error == nil && metadata != nil {
                
                // Save a reference to the file in Firestore DB with other data
                let db = Firestore.firestore()
                db.collection("books").document().setData(["url": "https://firebasestorage.googleapis.com/v0/b/elib-658e7.appspot.com/o/\(path)?alt=media", "isbn": isbn, "title": title, "author": author, "year": year, "description": description]) { error in
                    
                    // if there were no erro, display the new image
                    if error == nil {
                        DispatchQueue.main.async {
                            self.retrivedImages.append(self.selectedImage!)
                        }
                    }
                }
            }
        }
    }
    
    // Fetch Photo
    func retriveData() {
        
        // Get the data from the DB
        let db = Firestore.firestore()
        
        db.collection("books").getDocuments { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                var paths = [String]()
                
                // Loop through all the returned docs
                for doc in snapshot!.documents {
                    
                    // Extract the file path
                    paths.append(doc["url"] as! String)
                }
                
                // Loop through each file path and fetch data from storage
                for path in paths {
                    
                    // Get a reference to a storage
                    let storageRef = Storage.storage().reference()
                    
                    // Specify the path
                    let fileRef = storageRef.child(path)
                    
                    // Retrieve the path
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        
                        if error == nil  && data != nil {
                            
                            // Create a UIImage and put it into our array for display
                            if let image = UIImage(data: data!) {
                                DispatchQueue.main.async {
                                    retrivedImages.append(image)
                                }
                            }
                        }
                    }
                } // End of loop through path
            }
        }
        
        // Display the images
    }
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

struct CustomAlertView: View {
    
    @Binding var show : Bool
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack(spacing: 25) {
                Image(systemName: "checkmark.circle.fill")
                Text("Congratulations!")
                    .font(.custom(customFont, size: 20))
                    .fontWeight(.bold)
                Text("You've successfully published your book.")
                Button {
                    withAnimation {
                        show.toggle()
                    }
                } label: {
                    Text("Back")
                        .font(.custom(customFont, size: 20))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(
                            Color(red: 0.2, green: 0.0, blue: 0.7)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                        )
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlureView())
            .cornerRadius(25)
            .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
        )
    }
}

struct BlureView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
