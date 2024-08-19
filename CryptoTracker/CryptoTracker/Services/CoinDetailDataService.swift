//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 19/08/24.
//

import Foundation
import Combine


class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin:CoinModel
    
    init(coin:CoinModel) {
        self.coin = coin
        getCoinsDetails()
}

    func getCoinsDetails() {
     
     //URL : https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&communit_data=false&developer_data=false&sparkline=false
        var components = URLComponents(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)")
    components?.queryItems = [
        URLQueryItem(name: "localization", value: "false"),
        URLQueryItem(name: "tickers", value: "false"),
        URLQueryItem(name: "market_data", value: "false"),
        URLQueryItem(name: "communit_data", value: "false"),
        URLQueryItem(name: "developer_data", value: "false"),
        URLQueryItem(name: "sparkline", value: "false")
    ]
    
    guard let url = components?.url else { return }
            
        coinDetailSubscription = NetworkingManager.download(url: url, method: "GET")
        .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
            self?.coinDetails = returnedCoinDetails
            self?.coinDetailSubscription?.cancel()
        })
}
}
