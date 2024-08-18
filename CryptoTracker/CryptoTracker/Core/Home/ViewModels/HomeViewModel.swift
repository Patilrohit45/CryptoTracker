//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 15/08/24.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    
    @Published var statistics:[StatisticsModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    @Published var searchText:String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        /// Demo Data
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
        //            self.allCoins.append(DeveloperPreview.instance.coin)
        //            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        //        }
        
        /// API Data
        addSubscribers()
    }
    
    func addSubscribers() {
        //         dataService.$allCoins
        //            .sink { [weak self](returnedCoins) in
        //                self?.allCoins = returnedCoins
        //            }
        //            .store(in: &cancellables)
        
        // Updates all coins as well as with search text also
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Updates MarketData
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink{ [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        // Updates the portfolio coin
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels,portfolioEntities) -> [CoinModel] in
                coinModels.compactMap { (coin) -> CoinModel? in
                    guard let entity = portfolioEntities.first(where: {$0.coinId == coin.id}) else {
                        return nil
                    }
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { (returnedCoins) in
                self.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
            
    }
    
    func updatePortfolio(coin:CoinModel,amount:Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text:String,coins:[CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else{
            return coins
        }
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
        
    private func mapGlobalMarketData(marketdata:MarketDataModel?) ->  [StatisticsModel] {
        var stats: [StatisticsModel] = []
        
        guard let data = marketdata else {
            return stats
        }
        let marketCap = StatisticsModel(title: "Market_cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = StatisticsModel(title: "24h Volume", value: data.volume)
        
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolio = StatisticsModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
    }
}
