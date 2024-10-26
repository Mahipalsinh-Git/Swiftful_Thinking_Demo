//
//  Color.swift
//  CryptoApp
//
//  Created by Mahipal on 26/10/24.
//

import Foundation
import SwiftUICore

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let accentColor: Color = Color("AccentColor")
    let backgroundColor: Color = Color( "BackgroundColor")
    let greenColor: Color = Color("GreenColor")
    let redColor: Color = Color("RedColor")
    let secondaryTextColor: Color = Color("SecondaryTextColor")
}
