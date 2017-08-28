//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Aaryn Biro on 2017-05-17.
//  Copyright © 2017 Aaryn Biro. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    @IBOutlet weak var dayLabel: UILabel!
    
    
    @IBOutlet weak var weatherType: UILabel!
    
    @IBOutlet weak var highTemp: UILabel!
    
    
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forcast:Forecast){
        lowTemp.text = "\(forcast.lowTemp)"
        highTemp.text = "\(forcast.highTemp)"
        weatherType.text = forcast.weatherType
        weatherIcon.image = UIImage(named: forcast.weatherType)
        dayLabel.text = forcast.date
    }

}
