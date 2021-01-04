//
//  ContactsMapViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/3/21.
//

import UIKit
import MapKit
import RealmSwift


class ContactsMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var lastAnnotation: MKAnnotation!
    let kDistanceMeters: CLLocationDistance = 50
    var locationManager:CLLocationManager!
    var contacts = try! Realm().objects(Contact.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        populateMap()
    }
    

    @IBAction func logAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        addNewPin()
    }
    
    @IBAction func searchForCurrentPosition(_ sender: UIBarButtonItem) {
        centerToUsersLocation()
    }
    
    
    func centerToUsersLocation() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
       // locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.distanceFilter = 20
        self.mapView.userTrackingMode = .follow
    }
    
    @IBAction func unwindFromAddNewEntry(segue: UIStoryboardSegue) {
        let addNewEntryController = segue.source as! AddNewEntryViewController
         let addedContact = addNewEntryController.contact!
         let addedContactCoordinate = CLLocationCoordinate2D(
           latitude: addedContact.latitude,
           longitude: addedContact.longitude)
           
         if let lastAnnotation = lastAnnotation {
           mapView.removeAnnotation(lastAnnotation)
         } else {
           for annotation in mapView.annotations {
             if let currentAnnotation = annotation as? ContactAnnotation {
               if currentAnnotation.coordinate.latitude == addedContactCoordinate.latitude &&
                 currentAnnotation.coordinate.longitude == addedContactCoordinate.longitude {
                   mapView.removeAnnotation(currentAnnotation)
                   break
               }
             }
           }
         }
           
         let annotation = ContactAnnotation(
           coordinate: addedContactCoordinate,
           title: addedContact.name,
           subtitle: addedContact.category.name,
           contact: addedContact)
           
         mapView.addAnnotation(annotation)
         lastAnnotation = nil;
       }
    
    func addNewPin() {
      if lastAnnotation != nil {
        let alertController = UIAlertController(title: "Annotation already dropped",
                                                message: "There is an annotation on screen.",
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
          alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
      } else {
        let specimen = ContactAnnotation(coordinate: mapView.centerCoordinate, title: "Empty", subtitle: "Uncategorized")
        
        mapView.addAnnotation(specimen)
        lastAnnotation = specimen
      }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if (segue.identifier == "NewEntry") {
        let controller = segue.destination as! AddNewEntryViewController
        let contactAnnotation = sender as! ContactAnnotation
        controller.selectedAnnotation = contactAnnotation
      }
    }
    
    func populateMap() {
      mapView.removeAnnotations(mapView.annotations)
      contacts = try! Realm().objects(Contact.self)

      // Create annotations for each one
      for contact in contacts {
        let coord = CLLocationCoordinate2D(
          latitude: contact.latitude,
          longitude: contact.longitude);
        let contactAnnotation = ContactAnnotation(
          coordinate: coord,
          title: contact.name,
          subtitle: contact.category.name,
          contact: contact)
        mapView.addAnnotation(contactAnnotation)
      }
    }
 
}



extension ContactsMapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if let specimenAnnotation =  annotationView.annotation as? ContactAnnotation {
      performSegue(withIdentifier: "NewEntry", sender: specimenAnnotation)
    }
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
               didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
    
    if newState == .ending {
      view.dragState = .none
    }
  }
  
  func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
    for annotationView in views {
      if (annotationView.annotation is ContactAnnotation) {
        annotationView.transform = CGAffineTransform(translationX: 0, y: -500)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
          annotationView.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
      }
    }
  }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      guard let subtitle = annotation.subtitle! else {
        return nil
      }
      
      if (annotation is ContactAnnotation) {
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: subtitle) {
          return annotationView
        } else {
          let currentAnnotation = annotation as! ContactAnnotation
          let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: subtitle)
          
          annotationView.isEnabled = true
          annotationView.canShowCallout = true
          annotationView.image = UIImage(named: "IconUncategorized")

          let detailDisclosure = UIButton(type: .detailDisclosure)
          annotationView.rightCalloutAccessoryView = detailDisclosure
          
          if currentAnnotation.title == "Empty" {
            annotationView.isDraggable = true
          }
          
          return annotationView
        }
      }
      
      return nil
    }
}

extension ContactsMapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    status != .notDetermined ? mapView.showsUserLocation = true : print("Authorization to use location data denied")
  }
}
