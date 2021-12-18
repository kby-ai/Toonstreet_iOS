//
//  TSImageManager.swift
//  Toonstreet
//
//  Created by Kavin Soni on 19/12/21.
//

import UIKit
import Combine

class TSImageManager {
    static let shared = TSImageManager()

    private init() { }

    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let session = URLSession(configuration: configuration)

        return session
    }()

    enum ImageManagerError: Error {
        case invalidResponse
    }

    func imagePublisher(for url: URL, errorImage: UIImage? = nil) -> AnyPublisher<UIImage?, Never> {
        session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    200..<300 ~= httpResponse.statusCode,
                    let image = UIImage(data: data)
                else {
                    throw ImageManagerError.invalidResponse
                }

                return image
            }
            .replaceError(with: errorImage)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension Publishers {
    
    class DataSubscription<S: Subscriber>: Subscription where S.Input == Data, S.Failure == Error {
        private let session = URLSession.shared
        private let request: URLRequest
        private var subscriber: S?
        
        init(request: URLRequest, subscriber: S) {
            self.request = request
            self.subscriber = subscriber
            sendRequest()
        }
        
        func request(_ demand: Subscribers.Demand) {
            //TODO: - Optionaly Adjust The Demand
        }
        
        func cancel() {
            subscriber = nil
        }
        
        private func sendRequest() {
            guard let subscriber = subscriber else { return }
            session.dataTask(with: request) { (data, _, error) in
                _ = data.map(subscriber.receive)
                _ = error.map { subscriber.receive(completion: Subscribers.Completion.failure($0)) }
            }.resume()
        }
    }

        
        struct DataPublisher: Publisher {
            typealias Output = Data
            typealias Failure = Error
            
            private let urlRequest: URLRequest
            
            init(urlRequest: URLRequest) {
                self.urlRequest = urlRequest
            }
            
            func receive<S: Subscriber>(subscriber: S) where
                DataPublisher.Failure == S.Failure, DataPublisher.Output == S.Input {
                    let subscription = DataSubscription(request: urlRequest,
                                                        subscriber: subscriber)
                    subscriber.receive(subscription: subscription)
            }
        }
    }
extension URLSession {
    func dataResponse(for request: URLRequest) -> Publishers.DataPublisher {
        return Publishers.DataPublisher(urlRequest: request)
    }
}
