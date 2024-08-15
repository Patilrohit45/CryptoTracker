//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 15/08/24.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconeName:String
    
    var body: some View {
        Image(systemName: iconeName)
            .font(.headline)
            .foregroundColor(Color.theme.accentColor)
            .frame(width:50,height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.backgroundColor)
            )
            .shadow(
                color: Color.theme.accentColor.opacity(0.25),
                radius: 10, x: 0,y: 0
            )
            .padding( )
    }
}

#Preview {
    Group{
        CircleButtonView(iconeName: "info")
            .previewLayout(.sizeThatFits)
        
        CircleButtonView(iconeName: "plus")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
   
}
