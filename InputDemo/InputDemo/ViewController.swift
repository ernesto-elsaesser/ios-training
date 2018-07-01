import UIKit

public class ViewController: UIViewController {
    
    var textField: UITextField!
    var bottomConstraint: NSLayoutConstraint!
    
    let bottomMargin: CGFloat = 120
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
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
        
        NotificationCenter.default.addObserver(
        forName: .UIKeyboardWillShow, object: nil, queue: .main) { notification in
            
            if
                let info = notification.userInfo,
                let frameValue = info[UIKeyboardFrameBeginUserInfoKey] as? NSValue,
                let durationValue = info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
                
                self.animte(to: frameValue.cgRectValue.height, duration: durationValue.doubleValue)
            }
            
            
        }
        
        NotificationCenter.default.addObserver(
        forName: .UIKeyboardWillHide, object: nil, queue: .main) { notification in
            
            if
                let info = notification.userInfo,
                let durationValue = info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
                    self.animte(to: 0, duration: durationValue.doubleValue)
            }
        }
    }
    
    func animte(to offset: CGFloat, duration: TimeInterval) {
        
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
