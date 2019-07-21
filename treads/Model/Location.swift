//
//  Location.swift
//  treads
//
//  Created by Islam Kasem on 21/07/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import Foundation
import RealmSwift

class Location :Object {
    dynamic public private(set) var longtitude = 0.0
    dynamic public private(set) var latitude = 0.0
 
    convenience init (longtitude : Double , latitude : Double ){
        self.init()
        self.longtitude = longtitude
        self.latitude = latitude
    }
}
