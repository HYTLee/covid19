//
//  MapViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 12/20/20.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    var locationManager:CLLocationManager!
    var currentLocationStr = "Current location"
    @IBOutlet weak var addressSearchLine: UISearchBar!
    @IBOutlet weak var homeAdressLabel: UILabel!
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.userTrackingMode = .follow
        addressSearchLine.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
            determineCurrentLocation()
        }
    
  
    
    @IBAction func setChoosedAdress(_ sender: Any) {
        getCurrentMapAddress()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        addressSearchLine.resignFirstResponder()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressSearchLine.text!) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                
                let placemark = placemarks?.first
                
                let anno = MKPointAnnotation()
                anno.coordinate = (placemark?.location?.coordinate)!
                anno.title = self.addressSearchLine.text!
            
                self.mapView.addAnnotation(anno)
                self.mapView.selectAnnotation(anno, animated: true)
                
                
                
            }else{
                print(error?.localizedDescription ?? "error")
            }
            
            
        }
        
        
    }
    

    func getCurrentMapAddress()  {
        self.latitude = mapView.centerCoordinate.latitude
        self.longitude = mapView.centerCoordinate.longitude
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: latitude!, longitude:longitude!)) { (places, error) in
                if error == nil{
                    if let place = places{
                        self.homeAdressLabel.text = place.description
                    }
                }
        }
    }
        
        

  /*  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let mUserLocation:CLLocation = locations[0] as CLLocation

            let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
            let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

            mapView.setRegion(mRegion, animated: true)
        } */
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error - locationManager: \(error.localizedDescription)")
        }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
     //   locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 20


        if CLLocationManager.locationServicesEnabled() {
         //  locationManager.startUpdatingLocation()
        }
    }
    

    
    func scheduleNotification() {
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: latitude ?? 20, longitude: longitude ?? 20), radius: 20, identifier: "Home")
        
        locationManager.startMonitoring(for: geoFenceRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           
           for currentLocation in locations{
               print("\(index): \(currentLocation)")
           }
       }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
           print("Entered: \(region.identifier)")
       }
       
       func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
           print("Exited: \(region.identifier)")
           postLocalNotification()
        print("User left home")
       }
    
    
    func postLocalNotification()  {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "Allert"
        content.body = "Don't forget to take mask"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let notificationRequest: UNNotificationRequest = UNNotificationRequest(identifier: "home", content: content, trigger: trigger)
        
        center.add(notificationRequest) { (error) in
            if let error = error {
                print(error)
            }
            
            else {
                
                print("added")
            }
        }
    }
    
    @IBAction func setNotificationForCurrentLocation(_ sender: Any) {
        scheduleNotification()
    }

    
}
