//
//  Weather.swift
//  weatherApp
//
//  Created by Vladislav on 4/18/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import Foundation
struct Weather: Codable {
    let forecast: Forecast
}
struct Forecast: Codable {
    let simpleForecast: SimpleForecast
    private enum CodingKeys: String, CodingKey {
        case simpleForecast = "simpleforecast"
    }
}
struct SimpleForecast: Codable {
    let forecastDays: [ForecastDay]
    private enum CodingKeys: String, CodingKey {
        case forecastDays = "forecastday"
    }
}
struct ForecastDay: Codable {
    let date: DateDay
    let high: High
    let low: Low
    let iconUrl: URL
    let conditions: String
    let presipation: Presipation
    let aveHumidity: Int
    let aveWind: AveWind
    private enum CodingKeys: String, CodingKey {
        case date
        case high
        case low
        case conditions
        case iconUrl = "icon_url"
        case presipation = "qpf_allday"
        case aveWind = "avewind"
        case aveHumidity = "avehumidity"
    }
}

struct DateDay: Codable {
    let date: String
    let city: String
    private enum CodingKeys: String, CodingKey {
        case date = "epoch"
        case city = "tz_long"
    }
}
struct High: Codable {
    let temperatureHight: String
    private enum CodingKeys: String, CodingKey {
        case temperatureHight = "celsius"
    }
}
struct Low: Codable {
    let temperatureLow: String
    private enum CodingKeys: String, CodingKey {
        case temperatureLow = "celsius"
    }
}
struct Presipation: Codable {
    let percent: Double
    private enum CodingKeys: String, CodingKey {
        case percent = "in"
    }
}
struct AveWind: Codable {
    let wind: Int
    private enum CodingKeys: String, CodingKey {
        case wind = "mph"
    }
}


