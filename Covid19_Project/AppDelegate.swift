//
//  AppDelegate.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//
import UIKit
import Firebase
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
    static let geoCoder = CLGeocoder()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
         UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        FirebaseApp.configure()
        /*center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        } */
     //   locationManager.requestAlwaysAuthorization()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

