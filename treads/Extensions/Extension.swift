//
//  Extension.swift
//  treads
//
//  Created by Islam Kasem on 13/07/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import Foundation

extension Double{
    func metersToMiles (places : Int) -> Double{
        let devisor = pow(10.0, Double(places))
        return ((self / 1609.34) * devisor).rounded() / devisor
    }
    
    
    func metersToKilometers (places : Int) -> Double{
        let devisor = pow(10.0, Double(places))
        return ((self / 1000) * devisor).rounded() / devisor
    }
    

}

extension Int {
    func formatTimeDurationToString() -> String {
        let durationHours = self / 3600
        let durationMinutes = (self % 3600) / 60
        let durationSeconds = (self % 3600 ) % 60
    
        if durationSeconds < 0 {
            return "00:00:00"
        }else {
            if durationHoursx == 0  {
                return String(format : "%02d:%02d" , durationMinutes , durationSeconds)
            }else{
                return String(format : "%02d:%02d:%02d", durationHours , durationMinutes , durationSeconds)
            }
        }
    }
}

