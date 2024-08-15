//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 15/08/24.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject{
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    private let dataService = CoinDataService()
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
         dataService.$allCoins
            .sink { [weak self](returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }

}
