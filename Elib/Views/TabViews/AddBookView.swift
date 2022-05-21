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
import FirebaseAuth

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
    @State var HUD = false
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                
                // Select and Change Button
                VStack {
                    Text("Add new book")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 22)
                    
                   if selectedImage != nil {
                       Image(uiImage: selectedImage!)
                           .resizable()
                           .frame(maxWidth: 240, maxHeight: 320)
                           .scaledToFill()
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
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Author", text: $author)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Year", text: $year)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        
                    // Add Book button
                    
                    if selectedImage != nil {
                        Button {
                            uploadPhoto()
                            
                            withAnimation() {
                                customAlert.toggle()
                            }
                        
                            withAnimation() {
                                HUD.toggle()
                            }
                            
                        
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
                        Text("Clear")
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
                .padding(.horizontal, 30)
                    .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                    
                    // Image picker
                    ImagePicker(selectedImage: $selectedImage, isPickerShowign: $isPickerShowing )
                }
            }
            .background(Color(.systemGray6))
            
            if customAlert {
                CustomAlertView(show: $customAlert)
            }
            
            if HUD {
                HUDProgressView(placeHolder: "Please wait", show: $HUD)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .background(Color(.systemGray6))
    }
    

    // Uploading Photo and Data
    func uploadPhoto() {
        
        // Make sure that the selected image isn't nil
        guard selectedImage != nil else { return }
        
        // Geting userID for adding data to myLibrary page
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
         
        // Turn our image into data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        // Check that we were able to convert it to data
        guard imageData != nil else { return }
        
        // Specify the file path and name
        let path = "\(UUID().uuidString).jpeg"
        let fileRef = storageRef.child(path)
        
        DispatchQueue.main.async {
            // Upload that data
            _ = fileRef.putData(imageData!, metadata: nil) { metadata, error in
                
                // Check for error
                if error == nil && metadata != nil {
                    
                    // Save a reference to the file in Firestore DB with other data
                    let db = Firestore.firestore()
                    db.collection("books").document().setData(["url": "https://firebasestorage.googleapis.com/v0/b/elib-658e7.appspot.com/o/\(path)?alt=media", "isbn": isbn, "title": title, "author": author, "year": year, "description": description, "uid": userID])
                }
            }
        }
    }
    
    // Fetch Photo
//    func retriveData() {
//
//        // Get the data from the DB
//        let db = Firestore.firestore()
//
//        db.collection("books").getDocuments { snapshot, error in
//
//            if error == nil && snapshot != nil {
//
//                var paths = [String]()
//
//                // Loop through all the returned docs
//                for doc in snapshot!.documents {
//
//                    // Extract the file path
//                    paths.append(doc["url"] as! String)
//                }
//
//                // Loop through each file path and fetch data from storage
//                for path in paths {
//
//                    // Get a reference to a storage
//                    let storageRef = Storage.storage().reference()
//
//                    // Specify the path
//                    let fileRef = storageRef.child(path)
//
//                    // Retrieve the path
//                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//
//                        if error == nil  && data != nil {
//
//                            // Create a UIImage and put it into our array for display
//                            if let image = UIImage(data: data!) {
//                                DispatchQueue.main.async {
//                                    retrivedImages.append(image)
//                                }
//                            }
//                        }
//                    }
//                } // End of loop through path
//            }
//        }
//
//        // Display the images
//    }
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

struct HUDProgressView : View {
    
    var placeHolder : String
    @Binding var show : Bool
    @State var animate = false
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count: Int = 10
    
    var body: some View {
        VStack(spacing: 28) {
            Text("\(count)")
                .fontWeight(.bold)
            
            Circle()
            // for dark mode
                .stroke(AngularGradient(gradient: .init(colors: [Color.primary, Color.primary.opacity(0)]), center: .center))
                .frame(width: 80, height: 80)
            // animating
                .rotationEffect(.init(degrees: animate ? 360 : 0))
            
            Text(placeHolder)
                .fontWeight(.bold)
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 35)
        .background(BlureView())
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
                .onReceive(timer) { time in
                    // Closing view
                    if count <= 1 {
                        withAnimation {
                            show.toggle()
                        }
                    } else {
                        count -= 1
                    }
                }
                .ignoresSafeArea()
        )
        .onAppear{
            // Starting Animation
            withAnimation( Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                animate.toggle()
            }
        }
    }
}

struct CustomAlertView : View {
    
    @Binding var show : Bool
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    
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
                                .ignoresSafeArea()
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
                .onReceive(timer) { time in
                    // Closing view
                    if count >= 10 {
                        withAnimation {
                            show.toggle()
                        }
                    } else {
                        count += 1
                    }
                }
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
