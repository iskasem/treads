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
       
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
         mapView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMapView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    
    func setupMapView(){
        if let overLay = addLastRunToMap(){
            if mapView.overlays.count > 0{
              
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(overLay)
              print("after function addOverlay")
            lastRunStack.isHidden = false
            lastRunBgView.isHidden = false
            lastRunClosedBtn.isHidden = false
        }else{
            lastRunStack.isHidden = true
            lastRunBgView.isHidden = true
            lastRunClosedBtn.isHidden = true
        }
       
    }
    
    func addLastRunToMap () ->MKPolyline? {
        guard  let lastRun = Run.returnAllRuns()?.first else {return nil }
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToKilometers(places: 2)) km"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
        var coordinate = [CLLocationCoordinate2D]()
        for location in lastRun.locations{
            coordinate.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longtitude))
         
        }
        
        
        return MKPolyline(coordinates: coordinate, count: lastRun.locations.count)
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
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(overlay: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        renderer.lineWidth = 9
        return renderer
    }
}


