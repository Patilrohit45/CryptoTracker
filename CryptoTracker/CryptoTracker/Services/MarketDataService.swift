//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 17/08/24.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        var components = URLComponents(string: "https://api.coingecko.com/api/v3/global")
//        components?.queryItems = [
//            URLQueryItem(name: "vs_currency", value: "usd"),
//            URLQueryItem(name: "order", value: "market_cap_desc"),
//            URLQueryItem(name: "per_page", value: "250"),
//            URLQueryItem(name: "page", value: "1"),
//            URLQueryItem(name: "sparkline", value: "true"),
//            URLQueryItem(name: "price_change_percentage", value: "24h")
//        ]
        
        guard let url = components?.url else { return }
                
        marketDataSubscription = NetworkingManager.download(url: url, method: "GET")
            .decode(type: GloableData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
