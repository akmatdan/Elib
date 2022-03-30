//
//  OnBoardingView.swift
//  Elib
//
//  Created by Daniil Akmatov on 9/3/22.
//

import SwiftUI

// Custom font
let customFont = "Raleway-Regular"

struct OnBoardingView: View {
    @State var showLoginView: Bool = false
    
    var body: some View {
        
        VStack {
            Text("Manage your \nBook")
                .font(.custom(customFont, size: 46))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
            
            Image("onBoardImage1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
            
            Button {
                withAnimation{
                    showLoginView = true
                }
            } label: {
                Text("Get started")
                    .font(.custom(customFont, size: 23))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color(red: 0.2, green: 0.0, blue: 0.7))
                
            }
            .padding(.horizontal,30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.2, green: 0.0, blue: 0.7))
        // Showing LoginView
        .overlay(
            Group{
                if showLoginView{
                    LoginView()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
