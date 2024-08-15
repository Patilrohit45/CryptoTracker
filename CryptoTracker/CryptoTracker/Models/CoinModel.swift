//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 15/08/24.
//

import Foundation

// CoinGecko API Info
/*
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 JSON RESPONSE
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 58449.74760533117,
     "market_cap": 1153794467257,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1227429294991,
     "total_volume": 34773669629,
     "high_24h": 61538,
     "low_24h": 57812,
     "price_change_24h": -2604.4691826010167,
     "price_change_percentage_24h": -4.26583,
     "market_cap_change_24h": -50117101005.63696,
     "market_cap_change_percentage_24h": -4.16286,
     "circulating_supply": 19740187,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 73738,
     "ath_change_percentage": -20.78202,
     "ath_date": "2024-03-14T07:10:36.635Z",
     "atl": 67.81,
     "atl_change_percentage": 86044.46805,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2024-08-15T10:05:21.486Z",
     "sparkline_in_7d": {
       "price": [
         56901.8370801831,
         57188.716484365876,
         58370.951501063326,
         58313.335500366025
       ]
     }
   }
*/

struct CoinModel : Identifiable, Codable{
    let id, symbol, name: String
     let image: String
     let currentPrice: Double
     let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
     let high24H, low24H: Double?
     let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
     let circulatingSupply, totalSupply, maxSupply, ath: Double?
     let athChangePercentage: Double?
     let athDate: String?
     let atl, atlChangePercentage: Double?
     let atlDate: String?
     let lastUpdated: String?
     let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency:Double?
    let currentHoldings:Double?
    
    enum CodingKeys:String,CodingKey {
        case id,symbol,name,image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case sparklineIn7D = "sparkline_in_7d"
        case currentHoldings = "current_holdings"
        
    }
    
    func updateHoldings(amount:Double) -> CoinModel{
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingValue:Double{
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank:Int{
        return Int(marketCapRank ?? 0)
    }
 }

struct SparklineIn7D:Codable{
     let price: [Double]?
 }

