//
//  HiddenNavigationBar.swift
//  Elib
//
//  Created by Daniil Akmatov on 1/3/22.
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
            content
            .navigationBarTitle("", displayMode: .inline)
            .font(.title2)
            .foregroundColor(Color.black.opacity(0.7))
        }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}
