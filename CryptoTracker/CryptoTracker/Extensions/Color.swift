//
//  Color.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 15/08/24.
//

import Foundation
import SwiftUI

extension Color{
    
    
    static let theme = ColorTheme()
}

struct ColorTheme{
    
    let accentColor = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let greenColor = Color("GreenColor")
    let redColor = Color("RedColor")
    let secondaryTextColor = Color("SecondaryTextColor")
}
