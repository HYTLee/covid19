//
//  MapViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 12/20/20.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var locationManager:CLLocationManager!
    var currentLocationStr = NSLocalizedString("Current location", comment: "Current location")
    @IBOutlet weak var homeAdressLabel: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("ADDRESS", comment: "Title for vc")
        self.setRefreshBtn()
        self.setNotificationBtn()
        mapView.userTrackingMode = .follow
        determineCurrentLocation()
        if latitude == nil || longitude == nil {
            notificationBtn.isEnabled = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
            
            getCurrentMapAddress()
            if latitude != nil {
                notificationBtn.isEnabled = true
            }
        }
    
    @IBAction func setChoosedAdress(_ sender: Any) {
        getCurrentMapAddress()
    }

    func getCurrentMapAddress()  {
        self.latitude = mapView.centerCoordinate.latitude
        self.longitude = mapView.centerCoordinate.longitude
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: latitude!, longitude:longitude!)) { (places, error) in
                if error == nil{
                    if let place = places{
                        let readableAddressString =  "\(place[0].country ?? "\(NSLocalizedString("No country founded", comment: "No country founded"))"), \(place[0].locality ?? "\(NSLocalizedString("No street founded", comment: "No street founded"))")"
                        self.homeAdressLabel.text = readableAddressString
                    }
                }
        }
    }
    
    func setRefreshBtn() {
        refreshBtn.setTitle(NSLocalizedString("Refresh address", comment: "Refresh btn "), for: .normal)
    }
    
  
    
    func setNotificationBtn()  {
        notificationBtn.setTitle(NSLocalizedString("Set Notification", comment: "Set notification btn title"), for: .normal)
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error - locationManager: \(error.localizedDescription)")
        }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
       // locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 20
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
         //  print("Entered: \(region.identifier)")
       }
       
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
           print("Exited: \(region.identifier)")
           postLocalNotification()
       }
    
    
    func postLocalNotification()  {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = NSLocalizedString("Allert", comment: "Allert")
        content.body = NSLocalizedString("Don't forget to take mask", comment: "Don't forget to take mask")
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
        setAlertThatNotificationEnabledForLocation()
    }

    func setAlertThatNotificationEnabledForLocation()  {
        let alert = UIAlertController(title: "\(NSLocalizedString("Succes", comment: "Succes"))", message: "\(NSLocalizedString("Notification enabled and will remind you when you leave the house", comment: "Notification subtitile"))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}


