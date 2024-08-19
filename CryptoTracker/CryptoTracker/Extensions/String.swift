//
//  String.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 19/08/24.
//

import Foundation


extension String{
    
    var removingHTMLOccurances:String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression,range: nil)
    }
}
