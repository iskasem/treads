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

