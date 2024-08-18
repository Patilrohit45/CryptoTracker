//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 16/08/24.
//

import Foundation

/*
 API - https://api.coingecko.com/api/v3/global
 
 JSON RESPONSE -
 {
   "data": {
     "active_cryptocurrencies": 15087,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1171,
     "total_market_cap": {
       "btc": 36925976.0794812,
       "eth": 825082434.4864417,
       "ltc": 32980385142.89359,
       "bch": 6365559516.422961,
       "bnb": 4136129870.085115,
       "eos": 4421295415545.583,
       "xrp": 3797379071286.1553
    },
     "total_volume": {
       "btc": 1538764.0481753072,
       "eth": 34382494.974159464,
       "ltc": 1374345009.6925023,
       "bch": 265262971.22947887,
       "bnb": 172359098.3477775
     },
     "market_cap_percentage": {
       "btc": 53.46005196317441,
       "eth": 14.574238265048455,
       "usdt": 5.396969807080768,
       "bnb": 3.528395489922926
     },
     "market_cap_change_percentage_24h_usd": -0.9788782429322382,
     "updated_at": 1723800953
   }
 }
 */

struct GloableData: Codable{
    let data: MarketDataModel?
}

struct MarketDataModel: Codable{
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys:String,CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap:String{
        if let item = totalMarketCap.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbberviations()        }
        return ""
    }
    
    var volume:String{
        if let item = totalVolume.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbberviations()
        }
        return ""
    }

    var btcDominance:String{
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value.asPercentString()
        }
        return ""
    }
}
