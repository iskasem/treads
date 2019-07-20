//
//  RunLogCell.swift
//  treads
//
//  Created by Islam Kasem on 20/07/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {

    @IBOutlet weak var runDurationLbl: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var averagePaceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureRunLog(run:Run){
        runDurationLbl.text  = run.duration.formatTimeDurationToString()
        totalDistanceLbl.text = ("\(run.distance.metersToKilometers(places: 2)) km")
        averagePaceLbl.text = run.pace.formatTimeDurationToString()
        dateLbl.text = run.date.getDateString()
        
        
    }


}
