//
//  AppDelegate.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//
import UIKit
import Firebase
import CoreLocation
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
  
    
    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
    static let geoCoder = CLGeocoder()
    
    static var container = ContainerDependancies()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
         UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        let logOutListner = LogoutListner()
        FirebaseApp.configure()
        EventListnerManager.singleton.subscribe(listner: logOutListner, event: .logout, eventId: 1)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

