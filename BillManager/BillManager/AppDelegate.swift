//
//  AppDelegate.swift
//  BillManager
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else if granted {
                print("Notifications Enabled")
            } else {
                print("Notifications Disabled")
            }
        }
        
        let remindLaterAction = UNNotificationAction(identifier: "RemindLaterAction", title: "Remind in an Hour", options: [])
        let markAsPaidAction = UNNotificationAction(identifier: "MarkAsPaidAction", title: "Mark as Paid", options: .authenticationRequired)
        
        let billReminderCategory = UNNotificationCategory(identifier: Bill.notificationCategoryID, actions: [remindLaterAction, markAsPaidAction], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([billReminderCategory])
        
        center.delegate = self
        
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notificationID = response.notification.request.identifier
        print("Received notification with identifier: \(notificationID)")
        print("Action Identifer: \(response.actionIdentifier)")
        // Get the corresponding Bill for the notification ID
        if var bill = Database.shared.getBill(forNotificationID: notificationID) {
            switch response.actionIdentifier {
            case "MarkAsPaidAction":
                // The user selected the action to mark the bill as paid
                print("User selected action to mark the bill as paid")
                bill.paidDate = Date() // Set the paid date to now
                Database.shared.updateAndSave(bill) // Save the updated bill
            case "RemindLaterAction":
                // The user selected the action to be reminded later
                print("User selected action to be reminded later")
                let newReminderDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
                bill.scheduleReminder(newReminderDate) { scheduledBill in
                    // Save the updated bill after scheduling a new reminder
                    Database.shared.updateAndSave(scheduledBill)
                }
            default:
                break
            }
        }
    

        // Call the completion handler when done processing the notification
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("\(notification.request.identifier)")
        
        completionHandler([.banner, .sound, .badge])
    }
}



