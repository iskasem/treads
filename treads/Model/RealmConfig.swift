//
//  RealmConfig.swift
//  treads
//
//  Created by Islam Kasem on 22/07/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfig{
    static var runDataCongig :Realm.Configuration {
    let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALM_RUN_CONFIG)
    let config = Realm.Configuration(fileURL : realmPath ,
                                         schemaVersion: 0 ,
                                         migrationBlock :{ migration , oldSchemaVersion in
            if (oldSchemaVersion < 0 ){
            //nothing to do
            //Realm will automatically update the schema
                }
        })
        return config
    }
    }
