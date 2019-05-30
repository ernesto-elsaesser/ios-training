import UIKit

public class ViewController: UIViewController {
    
    var textField: UITextField!
    var bottomConstraint: NSLayoutConstraint!
    
    let bottomMargin: CGFloat = 120
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.placeholder = "Tap me"
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        self.textField = textField
        
        textField.delegate = self
        
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: bottomMargin)
        self.bottomConstraint = bottomConstraint
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            view.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 40),
            bottomConstraint
            ])
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            
            if
                let info = notification.userInfo,
                let frameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue,
                let durationValue = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
                
                self.animate(to: frameValue.cgRectValue.height, duration: durationValue.doubleValue)
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
            
            if
                let info = notification.userInfo,
                let durationValue = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
                    self.animate(to: 0, duration: durationValue.doubleValue)
            }
        }
    }
    
    func animate(to offset: CGFloat, duration: TimeInterval) {
        
        bottomConstraint.constant = bottomMargin + offset
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ViewController : UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return false
    }
}
