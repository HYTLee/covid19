//
//  ContactAnnotation.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/3/21.
//

import UIKit
import MapKit

class ContactAnnotation: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  var contact: Contact?

  
    init(
      coordinate: CLLocationCoordinate2D,
      title: String,
      subtitle: String,
      contact: Contact? = nil
      ) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.contact = contact
    }
}
