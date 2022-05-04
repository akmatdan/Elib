//
//  ProfileView.swift
//  Elib
//
//  Created by Daniil Akmatov on 5/3/22.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var loginData: LoginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("My Profile")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text("Dan Akmat")
                            .font(.custom(customFont, size: 18))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: Tynalieva 1000/3 Bishkek, Kyegyzstan")
                                .font(.custom(customFont, size: 15))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 40)
                    
                    // Custom Navigation Links
                    CustomNavigationLink(title: "Account settings") {
                        Text("")
                            .navigationTitle("Account settings")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Display settings") {
                        Text("")
                            .navigationTitle("Display settings")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Notification settings") {
                        Text("")
                            .navigationTitle("Notification settings")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Reports & Statistics") {
                        Text("")
                            .navigationTitle("Reports & Statistics")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Import & Export") {
                        Text("")
                            .navigationTitle("Import & Export")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Terms and privacy policy") {
                        Text("")
                            .navigationTitle("Edit Profile")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Contact us") {
                        Text("")
                            .navigationTitle("Contact us")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Button {
                        loginData.signOut()
                    } label: {
                        Text("Logout")
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
                .padding(.vertical, 20)
                .padding(.horizontal, 22)
            }
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
