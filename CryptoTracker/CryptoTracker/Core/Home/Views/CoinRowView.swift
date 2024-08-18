//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 15/08/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    
    let showHoldingsCoumn:Bool
    
    var body: some View {
        HStack(spacing:0){
            leftColumn
            Spacer()
            if showHoldingsCoumn {
              centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .background(
            Color.theme.backgroundColor
        )
    }
}

struct CoinRowView_Previews:PreviewProvider{
    static var previews: some View{
        Group{
            CoinRowView(coin: dev.coin, showHoldingsCoumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingsCoumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


extension CoinRowView{
    
    private var leftColumn:some View{
        HStack(spacing:0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth:30)
            CoinImageView(coin: coin)
                .frame(width:30,height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accentColor)
        }
    }
    
    private var centerColumn:some View{
        VStack(alignment:.trailing){
            Text(coin.currentHoldingValue.asCurrencyWith6Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accentColor)
    }
    
    private var rightColumn:some View{
        VStack(alignment:.trailing){
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundColor(Color.theme.accentColor)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0)
                    >= 0 ? Color.theme.greenColor : Color.theme.redColor
                )
        }
        .frame(width:UIScreen.main.bounds.width / 3.5,alignment: .trailing)
    }
}
