//
//  Endpoint.swift
//  weatherApp
//
//  Created by Vladislav on 4/19/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponent: URLComponents{
        var component = URLComponents(string: baseUrl)
        component?.path = path
        component?.queryItems = queryItems
        return component!
    }
    
    var request: URLRequest {
        return URLRequest(url: urlComponent.url!)
    }
}

enum WeatherEndpoint: Endpoint {
    case tenDayForecat(longitude: String, latitude: String)
    
    var baseUrl: String{
        return "http://api.wunderground.com"
    }
    
    var path: String{
        switch self{
        case .tenDayForecat(let longitude, let latitude):
            return "/api/1661e88a8ba41a84/forecast10day/q/\(latitude),\(longitude).json"
        }
    }
    var queryItems: [URLQueryItem] {
        return[]
    }
}
