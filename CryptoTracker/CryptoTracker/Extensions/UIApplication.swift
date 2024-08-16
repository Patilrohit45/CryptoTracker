//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 16/08/24.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
