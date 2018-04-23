//
//  CustomTableViewCell.swift
//  Weather
//
//  Created by Vladislav on 4/22/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayTextlbl: UILabel!
    @IBOutlet weak var descriptionTextlbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureTextLbl: UILabel!
    @IBOutlet weak var temperatureLowTextLbl: UILabel!
    @IBOutlet weak var aveWindTextLbl: UILabel!
    @IBOutlet weak var aveHumidityTextLbl: UILabel!
    @IBOutlet weak var presipationTextLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
