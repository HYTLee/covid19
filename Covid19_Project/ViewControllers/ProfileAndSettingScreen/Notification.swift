
import Foundation
import UserNotifications


class Notification {
    
    let center = UNUserNotificationCenter.current()
    var dateComponents = DateComponents()

    func getNotificationPermission()  {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Got")
            } else {
                print("Didn't got")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()

        content.title = "Covid 19"
        content.body = "Don't forget to check recent news about pandemic"
        content.categoryIdentifier = "news"
        content.sound = UNNotificationSound.default

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
}
