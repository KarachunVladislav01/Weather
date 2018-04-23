//
//  WeatherCellViewModal.swift
//  weatherApp
//
//  Created by Vladislav on 4/20/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import UIKit

struct WeatherCellViewModel {
    let url: URL
    let date: String
    let city: String
    let hight: String
    let low: String
    let presipation: Double
    let aveHumidity: Int
    let aveWind: Int
    let conditions: String
    
    func loadImage(comletion: @escaping (UIImage?) -> Void) {
        guard let imageData = try? Data(contentsOf: url) else {
            return
        }
        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
            comletion(image)
        }
    }
    func dateShort(date: Double) -> String {
        let rawDate = Date(timeIntervalSince1970: date)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "E\ndd.MM"
        dateFormater.string(from: rawDate)
        return "\(dateFormater.string(from: rawDate))"
    }
    func dateLong(date: Double) -> String {
        let rawDate = Date(timeIntervalSince1970: date)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEEE\nMMM dd. YYYY"
        dateFormater.string(from: rawDate)
        return "\(dateFormater.string(from: rawDate))"
    }
    func spliCity(city: String) -> String {
        let fullLoction = city.components(separatedBy: "/")
        return fullLoction[1]
    }
}
