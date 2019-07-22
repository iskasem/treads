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
 @objc dynamic public private(set) var id = ""
 @objc dynamic public private(set) var duration = 0
 @objc dynamic public private(set) var pace = 0
 @objc dynamic public private(set) var distance = 0.0
 @objc dynamic public private(set) var date = NSDate()
 dynamic public private(set) var locations = List<Location>()
    
   override class  func primaryKey () ->String {
        return "id"
    }
    override class func indexedProperties() -> [String] {
        return ["duration","date","pace"]
    }
    
    
    convenience  init(duration : Int , pace : Int , distance : Double, locations : List<Location>) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        self.locations = locations
        
    }
    
    static func addRunToRealm(pace :Int , duration :Int , distance :Double , locations :List<Location>){
        // Persist your data easily
    
        REALM_QUE.sync {
            let run = Run(duration: duration, pace: pace, distance: distance ,locations: locations)
           // print("this is the data of run\(run)")
            do{
                let realm = try Realm(configuration: RealmConfig.runDataCongig)
                try realm.write {
                    realm.add(run)
                   // print("duration inside addToRealm is \(duration)")
                 try realm.commitWrite()
                }
            }catch {
                debugPrint("error in saving\(error.localizedDescription)")
            }
        }
    }
    
    static func returnAllRuns() -> Results<Run>? {
        do{
        let realm = try Realm(configuration: RealmConfig.runDataCongig)
        var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
        let runSorted = runs
            //print("date max is \(runSorted[0])")
            print("run sorted value is \(String(describing: runSorted.first?.id))")
            return runs
            
        }catch{
            return nil
        }
    }
    
}

