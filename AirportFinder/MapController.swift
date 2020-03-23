//
//  StartController.swift
//  AirportFinder
//
//  Created by André Escajeda Ríos on 22/03/20.
//  Copyright © 2020 André Escajeda Ríos. All rights reserved.
//

import MapKit
import UIKit

class MapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var airports: [Airport] = []
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .mutedStandard
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        view.addSubview(mapView)
        mapView.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        
        airports.forEach { (airport) in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: airport.location.latitude, longitude: airport.location.longitude)
            annotation.subtitle = "\(airport.city), \(airport.countryCode)"
            annotation.title = airport.name
            
            mapView.addAnnotation(annotation)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }

        if currentLocation == nil {
            if let userLocation = locations.last {
                let coordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
                mapView.setRegion(coordinateRegion, animated: true)
            }
        }
    }
}
