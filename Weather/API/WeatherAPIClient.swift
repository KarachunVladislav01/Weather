//
//  WeatherAPIClient.swift
//  weatherApp
//
//  Created by Vladislav on 4/19/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import Foundation

class WeatherAPIClient: APIClient {
    var session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func weather(with endpoint: WeatherEndpoint, completion: @escaping (Either<SimpleForecast, APIError>) -> Void ) {
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<Weather, APIError>) in
            switch either {
            case .value(let weather):
                let textForecast = weather.forecast.simpleForecast
                completion(.value(textForecast))
            case .error(let error):
                completion(.error(error))
            }
        }
        
    }
}
