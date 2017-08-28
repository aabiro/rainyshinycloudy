//
//  ViewController.swift
//  rainyshinycloudy
//
//  Created by Maureen Biro on 2017-05-17.
//  Copyright © 2017 Aaryn Biro. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation  //to access devices current location

class WeatherVC: UIViewController, UITextViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    //need delagate and data souce for this tableView outlet!
    @IBOutlet weak var tableView: UITableView!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
        //need to add tableView to delagate
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self
        
        //load the function and make it work
        currentWeather = CurrentWeather()
       
        
        

        //check URL
        // print(CURRENT_WEATHER_URL)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    //check authorization and save location
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            //this is not working -- returning null value when I need to get the location from location manager!!
            currentLocation = locationManager.location
            print(currentLocation)
        
            if currentLocation == nil {
                //London, ON
                Location.sharedInstance.latitude = 42.9849
                Location.sharedInstance.longitude = -81.2453
                
                
                //Location.sharedInstance.latitude = 36.393
                //Location.sharedInstance.longitude = 25.461
            } else {
            
            //set and save to singleton class
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
            
            }
            //need to save location to singleton class before loading app in view did load
            //currentLocation = locationManager.location
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    //setup UI to load downloaded data
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            //currentLocation = locationManager.location
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //downloading forecast weather data for tableview
      //  let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.tableView.reloadData()
                }
            }
          completed()
            
        }
        
    }
    
    
    //three required delagate methods for tableviews
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
       if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{

            let forcast = forecasts[indexPath.row]
            cell.configureCell(forcast: forcast)
            return cell
            
        } else {
            return WeatherCell()
        }
    }

    func updateMainUI() {
        //pass in data
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)" //turns double to string
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        
        //assets named the same as weathertype on json
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
 
    }
    

}

