import UIKit
import UserNotifications

public class ViewController: UIViewController {

    @IBAction func scheduleTapped(_ sender: Any) {

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                self.scheduleNotificaiton()
            } else {
                self.notify(title: "Error", message: "App is not allowed to send notifications!")
            }
        }
    }

    private func scheduleNotificaiton() {

        let content = UNMutableNotificationContent()
        content.title = "The title"
        content.body = "The body ..."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let identifier = "NotificationDemoNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

        self.notify(title: "Success", message: "Notification scheduled, close app to see it!")
    }

    private func notify(title: String, message: String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
