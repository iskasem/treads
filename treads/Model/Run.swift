//
//  Run.swift
//  treads
//
//  Created by Islam Kasem on 19/07/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import Foundation
import RealmSwift

class Run : Object {
 dynamic public private(set) var id = ""
 dynamic public private(set) var duration = 0
 dynamic public private(set) var pace = 0
 dynamic public private(set) var distance = 0.0
 dynamic public private(set) var date = NSDate()
    
    override class  func primaryKey () ->String {
        return "id"
    }
    override class func indexedProperties() -> [String] {
        return ["duration","date","pace"]
    }
    convenience  init(duraion : Int , pace : Int , distance : Double) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
    }

}
