//
//  MainList.swift
//  Elib
//
//  Created by Daniil Akmatov on 18/3/22.
//

import SwiftUI

struct MainList: View {
    
    var body: some View {
        
        VStack() {
            
            BookCardView()
            Spacer()
        }
    }
}

struct MainList_Previews: PreviewProvider {
    static var previews: some View {
        MainList()
    }
}
