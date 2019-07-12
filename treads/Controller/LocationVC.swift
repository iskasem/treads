//
//  LocationVC.swift
//  treads
//
//  Created by Islam Kasem on 12/07/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController , MKMapViewDelegate {

    var manager : CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.activityType = .fitness

    }
    
    func checkLocationAuthorizationStatus (){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            manager?.requestWhenInUseAuthorization()
        }
    }
    


}
