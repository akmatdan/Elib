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
    var body: some View {
        
        VStack {
            Text("Find your \nBook")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
