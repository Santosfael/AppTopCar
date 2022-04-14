//
//  MapViewController.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 08/04/22.
//

import UIKit

class MapViewController: UIViewController {
    
    //private let mapView = MapNativeView()
    private let mapView = GoogleMapView()
    
    override func loadView() {
        super.loadView()
        self.view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
    }

}
