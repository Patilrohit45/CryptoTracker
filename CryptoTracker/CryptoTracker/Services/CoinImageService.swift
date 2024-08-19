//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 16/08/24.
//

import Foundation
import SwiftUI
import Combine
class CoinImageService{
    
    @Published var image:UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private var coin:CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName:String
    
    init(coin:CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }

    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName){
            image = savedImage
            print("Retrieved image from file manager")
        }else{
            downloadCoinImage()
            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage(){
        let components = URLComponents(string: coin.image)
        
        guard let url = components?.url else { return }
                
        imageSubscription = NetworkingManager.download(url: url, method: "GET")
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self,let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
