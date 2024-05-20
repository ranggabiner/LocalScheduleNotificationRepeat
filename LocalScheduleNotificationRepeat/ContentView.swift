import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Peringatan Sholat"
                content.subtitle = "Anda belum Sholat"
                content.sound = UNNotificationSound.default

                // Menggunakan UNTimeIntervalNotificationTrigger dengan repeats: true (minimal interval 60 detik)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error adding notification: \(error.localizedDescription)")
                    } else {
                        print("Notification scheduled!")
                    }
                }
            }
            Button("Cancel Notifications") {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                print("All notifications cancelled!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
