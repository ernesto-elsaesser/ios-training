import UIKit

public class DrawingViewController: UIViewController {

    var imageView: UIImageView!
    var renderer : UIGraphicsImageRenderer!
    var currentPath : UIBezierPath?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize() {
        view.backgroundColor = .white
        
        let imageView = UIImageView()
        imageView.frame = view.bounds
        view.addSubview(imageView)
        self.imageView = imageView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        renderer = UIGraphicsImageRenderer(size: view.frame.size)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(drawRectangle))
        
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: view) else {
            return
        }
        
        let path = UIBezierPath()
        path.move(to: point)
        currentPath = path
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let path = currentPath else {
            return
        }
        
        guard let point = touches.first?.location(in: view) else {
            return
        }
        
        path.addLine(to: point)
        
        let image = renderer.image { ctx in
            
            ctx.cgContext.addPath(path.cgPath)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        currentPath = nil
    }
    
    // gesture recognizer target
    
    @IBAction func drawRectangle(recognizer:UITapGestureRecognizer) {
        
        guard recognizer.state == .ended else {
            return
        }
        
        let point = recognizer.location(in: view)
        let rect = CGRect(origin: point, size: CGSize(width: 15, height: 15))
        
        let fillColor: UIColor
        switch arc4random_uniform(3) {
        case 0:
            fillColor = .red
        case 1:
            fillColor = .yellow
        case 2:
            fillColor = .blue
        default:
            fillColor = .white
        }
        
        let image = renderer.image { ctx in
            
            ctx.cgContext.stroke(rect)
            ctx.cgContext.setFillColor(fillColor.cgColor)
            ctx.cgContext.fill(rect)
        }
        
        imageView.image = image
    }
}
