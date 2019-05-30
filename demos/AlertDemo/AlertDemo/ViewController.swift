import UIKit

public class ViewController: UIViewController {

    @IBAction func alertTapped(_ sender: Any) {

        let alertController = UIAlertController(title: "Error", message: "Something went wrong!", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func actionSheetTapped(_ sender: Any) {

        let alertController = UIAlertController(title: nil, message: "Please select one:", preferredStyle: .actionSheet)

        let option1 = UIAlertAction(title: "Option 1", style: .default) { _ in
            print("Option 1 selected")
        }
        alertController.addAction(option1)

        let option2 = UIAlertAction(title: "Option 2", style: .default) { _ in
            print("Option 2 selected")
        }
        alertController.addAction(option2)

        let option3 = UIAlertAction(title: "Option 3", style: .default) { _ in
            print("Option 3 selected")
        }
        alertController.addAction(option3)

        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func loginAlertTapped(_ sender: Any) {

        let alertController = UIAlertController(title: "Login", message: "Please enter your credentials:", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "E-Mail"
            textField.keyboardType = .emailAddress
        }

        alertController.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }

        let loginAction = UIAlertAction(title: "OK", style: .default) { (_) in
            let emailField = alertController.textFields![0]
            let passwordField = alertController.textFields![1]

            if let email = emailField.text, let password = passwordField.text {
                print("Logged in: \(email) - \(password)")
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(loginAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
