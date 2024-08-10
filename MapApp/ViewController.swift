//
//  ViewController.swift
//  MapApp
//
//  Created by Anastasia Gorbunova on 27.07.2024.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    private var searchBar: UISearchBar = {
        var bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    var locationManager: CLLocationManager?
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // init location manager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        
        setUpUI()
    }
    
    //MARK: - Private functions
    private func setUpUI() {
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .prominent
        //searchBar.bar
        
        view.addSubview(mapView)
        view.addSubview(searchBar)
        view.backgroundColor = .blue
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6)
        ])
        
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager,
              let location = locationManager.location else {return}
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: 750,
                                        longitudinalMeters: 750)
        mapView.setRegion(region, animated: true)
    }
    
    private func findNearbyPlaces(query: String) {
        //clear all annotations
        mapView.removeAnnotations(mapView.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response, error == nil else {return}
            let places = response.mapItems.map { item in
                return PlaceAnnotation(mapItem: item)
            }
            //self?.mapView.addAnnotations(places)
            let vc = ResultTableViewController(places: places)
            vc.modalPresentationStyle = .pageSheet
            self?.present(vc, animated: true)
            //print(response.mapItems)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
}

//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //findNearbyPlaces(query: searchText)
        print("TEXT DID CHANGE")
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("TEXT FINISHED CHANGING")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search b")
        let searchString = searchBar.text
        if let text = searchString {
            findNearbyPlaces(query: text)
        }
        searchBar.endEditing(true)
    }
}

