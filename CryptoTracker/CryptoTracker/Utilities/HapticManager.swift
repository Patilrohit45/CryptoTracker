//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 18/08/24.
//

import Foundation
import SwiftUI

class HapticManager{
    private static let generator = UINotificationFeedbackGenerator()
    
    static func notifications(type:UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
}
