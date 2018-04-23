//
//  ViewController.swift
//  weatherApp
//
//  Created by Vladislav on 4/18/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todayWeatherImage: UIImageView!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var todayCity: UILabel!
    @IBOutlet weak var todayWeather: UILabel!
    @IBOutlet weak var todayHighTemp: UILabel!
    @IBOutlet weak var todayLowTemp: UILabel!
    
    var cellViewModelsFull = [WeatherCellViewModel]()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refreshControl
    }()
    
    func callDelegat() {
        locationManger.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        callDelegat()
        tableView.rowHeight = 130
        tableView.separatorStyle = .none
        tableView.refreshControl = refresher
        locationManger.requestAlwaysAuthorization()
        let reachability = Reachability()
        
        if reachability.isConnectedToNetwork() == true{
            print("Connected to the internet")
            locationManger.startUpdatingLocation()
        } else {
            print("No internet connection")
            weatherFromLocalJSON()
        }
        super.viewDidLoad()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    @objc
    func requestData(){
        print("reqest")
        locationManger.startUpdatingLocation()
        self.refresher.endRefreshing()
    }
    
    func updateHeader( ){
        let cellViewModel = cellViewModelsFull[0]
        DispatchQueue.main.async {
            self.todayDate.text = cellViewModel.dateLong(date: Double(cellViewModel.date)!)
            self.todayCity.text = cellViewModel.spliCity(city: cellViewModel.city)
            self.todayWeather.text = cellViewModel.conditions
            self.todayHighTemp.text = "\(cellViewModel.hight)°C"
            self.todayLowTemp.text = "\(cellViewModel.low)°C"
            self.todayDate.numberOfLines = 0
            self.todayDate.textAlignment = .left
            cellViewModel.loadImage{ (image) in
                self.todayWeatherImage.image = image
            }
        }
        cellViewModelsFull.remove(at: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModelsFull.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! CustomTableViewCell
        let cellViewModel = cellViewModelsFull[indexPath.row]
        
        cell.dayTextlbl.text = cellViewModel.dateShort(date: Double(cellViewModel.date)!)
        cell.descriptionTextlbl.text = cellViewModel.conditions
        cell.temperatureTextLbl.text = "\(cellViewModel.hight)°C"
        cell.temperatureLowTextLbl.text = "\(cellViewModel.low)°C"
        cell.aveWindTextLbl.text = "\(cellViewModel.aveWind)mhp"
        cell.aveHumidityTextLbl.text = "\(cellViewModel.aveHumidity)%"
        cell.presipationTextLbl.text = "\(Int(cellViewModel.presipation*100))%"
        cell.dayTextlbl.numberOfLines = 0
        cell.dayTextlbl.textAlignment = .center
        
        cellViewModel.loadImage{ (image) in
            cell.weatherImage.image = image
        }
        return cell
    }
    
    func weatherFromLocalJSON() {
        if decodable() != nil {
            self.cellViewModelsFull = decodable().forecast.simpleForecast.forecastDays.map {
                WeatherCellViewModel(url: $0.iconUrl, date: $0.date.date,city: $0.date.city, hight: $0.high.temperatureHight, low: $0.low.temperatureLow, presipation: $0.presipation.percent, aveHumidity: $0.aveHumidity, aveWind: $0.aveWind.wind, conditions: $0.conditions)
            }
            self.updateHeader( )
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }else {
            print("JSON from file is equal nil")
        }
    }
    
    func weatherFromInternet(longitude: String, latitude: String) {
        let weatherApi = WeatherAPIClient()
        let weatherEndpoint = WeatherEndpoint.tenDayForecat(longitude: longitude , latitude: latitude)
        weatherApi.weather(with: weatherEndpoint) { (either) in
            switch either {
            case .value(let forecastText):
                self.cellViewModelsFull = forecastText.forecastDays.map {
                    WeatherCellViewModel(url: $0.iconUrl, date: $0.date.date,city: $0.date.city, hight: $0.high.temperatureHight, low: $0.low.temperatureLow, presipation: $0.presipation.percent, aveHumidity: $0.aveHumidity, aveWind: $0.aveWind.wind, conditions: $0.conditions)
                }
                self.updateHeader()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}



