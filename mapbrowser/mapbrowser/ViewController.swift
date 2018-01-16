//
//  ViewController.swift
//  mapbrowser
//
//  Created by Użytkownik Gość on 26.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressView: UITextView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    
    @IBAction func startClicked(_ sender: Any) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBAction func stopClicked(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        clearButton.isEnabled = true
        addressView.text = ""
        
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func setLocationLayout(location: CLLocation){
        mapView.setCenter(location.coordinate, animated: true)
        let adnotacja = MKPointAnnotation()
        adnotacja.coordinate = location.coordinate
        mapView.addAnnotation(adnotacja)
        
        // set zoom
        var delta: Double
        if location.speed >= 5 {
            delta = 0.01 * (location.speed / 10)
        }
        else {
            delta = 0.005
        }
        
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        // set geolabel
        self.setGeoLabel(la: location.coordinate.latitude, lo: location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]){
        guard let lastLocation = locations.last else {
            return
        }
        
        setLocationLayout(location: lastLocation)
    }
    
    func setGeoLabel(la: CLLocationDegrees, lo: CLLocationDegrees){
        let currentLocation = CLLocation(latitude: la, longitude: lo)
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks, error) -> Void in
            
            if placemarks != nil {
                let pmText = placemarks![0].locality
                self.addressView.text = pmText!
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startButton.isEnabled = true
        stopButton.isEnabled = false
        clearButton.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

