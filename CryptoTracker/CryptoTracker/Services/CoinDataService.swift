//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 15/08/24.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
     func getCoins() {
        var components = URLComponents(string: "https://api.coingecko.com/api/v3/coins/markets")
        components?.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "250"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "price_change_percentage", value: "24h")
        ]
        
        guard let url = components?.url else { return }
                
        coinSubscription = NetworkingManager.download(url: url, method: "GET")
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}

