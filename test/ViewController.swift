//
//  ViewController.swift
//  test
//
//  Created by Michael Shur on 11/10/15.
//  Copyright © 2015 Mike & Lucas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var longitude = Double()
    var latitude = Double()
    
    @IBOutlet var coordinates: UILabel!
    @IBOutlet var vmLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Ask for authoirzation from the user
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        longitude = locValue.longitude
        latitude = locValue.latitude
        coordinates.text = "longitude: \(longitude)  |  Latitude: \(latitude)"
        print(String(longitude))
        
        setUsersClosestCity()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {

        print("error = " + error.localizedDescription)
        
    }
    
    func setUsersClosestCity() {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude:longitude)
        geoCoder.reverseGeocodeLocation(location) {
                (placemarks, error) -> Void in
                
                let placeArray = placemarks as [CLPlacemark]!
                
                // Place details
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                
                // Address dictionary
//                print(placeMark.addressDictionary)
            
            
                // City
                if let city = placeMark.addressDictionary?["City"] as? NSString {
                    self.vmLocation.text = String(city)
            }
                
        }
    }
}

