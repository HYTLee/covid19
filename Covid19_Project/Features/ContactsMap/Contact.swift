//
//  Contact.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 1/3/21.
//

import Foundation
import RealmSwift

class Contact: Object {
  @objc dynamic var name = ""
  @objc dynamic var contactDescription = ""
  @objc dynamic var latitude = 0.0
  @objc dynamic var longitude = 0.0
  @objc dynamic var created = Date()
  @objc dynamic var category: Category!
}
