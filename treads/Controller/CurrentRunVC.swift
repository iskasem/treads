//
//  CurrentRunVC.swift
//  treads
//
//  Created by Islam Kasem on 12/07/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import UIKit
import MapKit

class CurrentRunVC: LocationVC {

    @IBOutlet weak var swipBGImageView: UIImageView!
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var pauseBtn: UIButton!
    
    var startLocation : CLLocation!
    var lastLocation : CLLocation!
    
    var runDistance = 0.0
    var counter = 0
    var timer = Timer()
    var pace = 0
    let resumeImage = UIImage(named: "resumeButton")
    let pauseImage = UIImage(named:  "pauseButton")
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwipe(sender: )))
        sliderImageView.addGestureRecognizer(swipeGesture)
        sliderImageView.isUserInteractionEnabled = true
        swipeGesture.delegate = self as?UIGestureRecognizerDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
    }
    
    func startRun(){
        manager?.startUpdatingLocation()
        startTimer()
        pauseBtn.setImage(pauseImage , for: .normal)
    
    }
    
    func endRun(){
        manager?.stopUpdatingLocation()
        //add our object to realm
        Run.addRunToRealm(pace: pace, distance: runDistance, duration: counter)
    }
    func startTimer(){
        durationLbl.text = counter.formatTimeDurationToString()
            //.formatTimeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func pauseRun (){
        startLocation = nil
        lastLocation = nil
        timer.invalidate()
        manager?.stopUpdatingLocation()
        pauseBtn.setImage(resumeImage, for: .normal)
    }
    
    @objc func updateCounter(){
        counter += 1
        durationLbl.text = counter.formatTimeDurationToString()
            //.formatTimeDurationToString()
    }
    func calculatePace (seconds :Int , distance : Double) ->String{
        pace = Int(Double(seconds)/distance)
        return pace.formatTimeDurationToString()
    }
    
    @IBAction func pauseRunBtnPressed(_ sender: Any) {
        if timer.isValid {
        pauseRun()
        }else{
            startRun()
        }
    }
    
    @objc func endRunSwipe(sender : UIPanGestureRecognizer){
        let minAdjust :CGFloat = 82
        let maxAdjust : CGFloat = 132
        if let sliderView = sender.view{
            if sender.state == UIGestureRecognizer.State.began || sender.state ==
                UIGestureRecognizer.State.changed{
                 let translation  = sender.translation(in: self.view)
                if sliderView.center.x >= (swipBGImageView.center.x - minAdjust) && sliderView.center.x <= (swipBGImageView.center.x + maxAdjust){
                    sliderView.center.x = sliderView.center.x + translation.x
                }else if sliderView.center.x >= (swipBGImageView.center.x + maxAdjust){
                    sliderView.center.x = swipBGImageView.center.x + maxAdjust
                    /// end run code should be here
                    endRun()
                    dismiss(animated: true, completion: nil)
                } else{
                    sliderView.center.x = swipBGImageView.center.x - minAdjust
                }
    
                 sender.setTranslation(CGPoint.zero, in: self.view)
            }else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1, animations: {
                    sliderView.center.x = self.swipBGImageView.center.x - minAdjust
                    
                    
                })
            }
           
        }
    }
  
}

extension CurrentRunVC : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthorizationStatus()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil{
            startLocation = locations.first
        }else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
        
            distanceLbl.text = "\(runDistance.metersToKilometers(places: 2))"
        }
        if counter > 0 && runDistance > 0 {
             paceLbl.text =  calculatePace(seconds: counter, distance: runDistance.metersToKilometers(places: 2))
        }
        lastLocation = locations.last
    }
}
