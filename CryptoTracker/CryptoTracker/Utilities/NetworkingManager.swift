//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 15/08/24.
//

import Foundation
import Combine

class NetworkingManager {
    
    
    enum NetworkingError: LocalizedError{
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String?{
            switch self{
            case .badURLResponse(url:let url):
                return "[🔥] Bad response from URL.\(url)"
            
            case .unknown:
                return "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func download(url:URL,method:String) -> AnyPublisher<Data,Error>{
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "x-cg-demo-api-key": "CG-pTFzR7AD2ujN11bBUsfv7Dai"
        ]
       return URLSession.shared.dataTaskPublisher(for: request)
           //.subscribe(on: DispatchQueue.global(qos: .default))
           .tryMap({ try handleURLResponse(output: $0,url: url) })
           .retry(3)
           .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output,url:URL) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url:url)
        }
        return output.data
    }
    
    static func handleCompletion(completion:Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let err):
            print(err.localizedDescription)
        }
    }
}
