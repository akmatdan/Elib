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
                    Text("Настройки")
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
                        
                        Text("...")
                            .font(.custom(customFont, size: 18))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("...")
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
                    CustomNavigationLink(title: "Настройка аккаунта") {
                        
                        
                        Text("")
                            .navigationTitle("Account settings")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Настройка дисплейя") {
                        Text("")
                            .navigationTitle("Display settings")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Настройка уведомления") {
                        Text("")
                            .navigationTitle("Notification settings")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Отчет и статистика") {
                        Text("")
                            .navigationTitle("Reports & Statistics")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    CustomNavigationLink(title: "Иморт и экспорт данных") {
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
                    
                    CustomNavigationLink(title: "Связаться с нами") {
                        Text("")
                            .navigationTitle("Contact us")
                            .background(Color(.systemGray6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Button {
                        loginData.signOut()
                    } label: {
                        Text("Выйти")
                            .font(.custom(customFont, size: 17).bold())
                            .fontWeight(.semibold)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color(red: 0.2, green: 0.0, blue: 0.7))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .padding(.top, 10)
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 22)
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(Color(.systemGray6))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
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
