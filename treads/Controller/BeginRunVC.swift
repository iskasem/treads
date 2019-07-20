//
//  BeginRunVC.swift
//  treads
//
//  Created by Islam Kasem on 29/06/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: LocationVC {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var lastRunClosedBtn: UIButton!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunBgView: UIView!
    @IBOutlet weak var lastRunStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorizationStatus()
        mapView.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
        getLastRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func getLastRun (){
        guard let lastRun = Run.returnAllRuns()?.first else {
            lastRunStack.isHidden = true
            lastRunBgView.isHidden = true
            lastRunClosedBtn.isHidden = true
            return
        }
        lastRunStack.isHidden = false
        lastRunBgView.isHidden = false
        lastRunClosedBtn.isHidden = false
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToKilometers(places: 2)) km"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
    }

    @IBAction func lastRunClosedBtnPressed(_ sender: Any) {
        lastRunStack.isHidden = true
        lastRunBgView.isHidden = true
        lastRunClosedBtn.isHidden = true
    }
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
    }
    
}

extension BeginRunVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthorizationStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
}
