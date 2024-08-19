//
//  Date.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 19/08/24.
//

import Foundation

extension Date{
    
    init(coinGeckoString:String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter:DateFormatter{
        let formmater = DateFormatter()
        formmater.dateStyle = .short
        return formmater
    }
    
    func asShortDateString() -> String{
        return shortFormatter.string(from: self)
    }
}
