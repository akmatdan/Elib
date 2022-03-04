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
        }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}
