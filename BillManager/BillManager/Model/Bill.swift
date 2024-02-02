// BillManager

import Foundation
import UserNotifications

struct Bill: Codable {
    let id: UUID
    var amount: Double?
    var dueDate: Date?
    var paidDate: Date?
    var payee: String?
    var remindDate: Date?
    var notificationID: String?
    
    static let notificationCategoryID = "BillReminderCategory"
    static let paidActionID = "Paid"
    init(id: UUID = UUID()) {
        self.id = id
    }
}

extension Bill: Hashable {
    
    
    private func formatAmount() -> String {
        if let amount = amount {
            return String(format: "$%.2f", amount)
        }
        return "Unknown Amount"
    }
    
    private func formatDueDate() -> String {
        if let dueDate = dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d/yyyy"
            return dateFormatter.string(from: dueDate)
        } else {
            return "Unknown Due Date"
        }
    }
    mutating func scheduleReminder(_ date: Date, completion: @escaping (Bill) -> Void) {
        removeReminders()
        
        var mutableSelf = self  // Create a local variable
        
        authorized { (granted) in
            guard granted else {
                DispatchQueue.main.async {
                    completion(mutableSelf)
                }
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Bill Reminder"
            content.body = "\(mutableSelf.formatAmount()) due to \(mutableSelf.payee ?? "Unknown") on \(mutableSelf.formatDueDate())."
            content.categoryIdentifier = Bill.notificationCategoryID
            
            let triggerDate = mutableSelf.remindDate ?? mutableSelf.dueDate ?? Date()
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate ), repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    mutableSelf.notificationID = request.identifier
                    mutableSelf.remindDate = date
                    
                    DispatchQueue.main.async {
                        completion(mutableSelf)
                    }
                }
            }
        }
    }
    
        mutating func removeReminders() {
            guard let notificationID = notificationID else {
                return
            }
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationID])
            
            self.notificationID = nil
            self.remindDate = nil
        }
        
        private func authorized(completion: @escaping (Bool) -> ()) {
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
                case .denied:
                    completion(false)
                case .authorized:
                    completion(true)
                default:
                    completion(false)
                    
                }
            }
        }
    }
