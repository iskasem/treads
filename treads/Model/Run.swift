//
//  Run.swift
//  treads
//
//  Created by Islam Kasem on 14/07/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import Foundation
import RealmSwift

class Run:Object {
    dynamic public private (set) var id = ""
    dynamic public private (set) var pace = 0
    dynamic public private (set) var distance = 0.0
    dynamic public private (set) var duration = 0
    dynamic public private (set) var date = NSDate()
    
     class func primarykey() -> String {
        return "id"
    }
    
     class func indexProperties () -> [String] {
    return ["page","date","duration"]
    }
    
    convenience init(pace : Int , distance : Double , duration : Int){
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.duration = duration
        self.distance = distance
    }
}
