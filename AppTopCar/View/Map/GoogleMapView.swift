//
//  GoogleMapView.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 09/04/22.
//

import UIKit
import GoogleMaps

class GoogleMapView: UIView {
    private var camera: GMSCameraPosition!
    private var mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    private let locationManager = CLLocationManager()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        delegates()
        //configMap()
    }
    
    private func delegates() {
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func configMap() {
        camera = GMSCameraPosition(latitude: -18.9532055, longitude: -46.9853697, zoom: 16)
        mapView = GMSMapView.map(withFrame: self.frame, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -18.9550696, longitude: -46.9875781)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension GoogleMapView: CodeView {
    func buildViewHierarchy() {
        addSubview(mapView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        
    }
}

extension GoogleMapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.camera = GMSCameraPosition(
            target: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? -18.9532055, longitude: locationManager.location?.coordinate.longitude ?? -46.9853697),
            zoom: 16,
            bearing: 0,
            viewingAngle: 0)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? -18.9550696, longitude: locationManager.location?.coordinate.longitude ?? -46.9875781)
        marker.title = "Lava-rápido"
        marker.snippet = "Lava-rápido"
        marker.map = mapView
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .authorizedAlways:
                return
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                locationManager.requestWhenInUseAuthorization()
            case .denied:
                return
            case .authorizedWhenInUse:
                return
            @unknown default:
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
