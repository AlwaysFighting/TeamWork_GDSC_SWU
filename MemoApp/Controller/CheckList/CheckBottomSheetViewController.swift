import UIKit

class CheckBottomSheetViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var BottomViewBackground: UIView!
    @IBOutlet weak var bottomDimmyView: UIView!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
        
    }
    
    
    // MARK: - Helpers

    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupUI(){
        
        // DimmyView
        bottomDimmyView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bottomDimmyView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        bottomDimmyView.layer.cornerRadius = 20
        
    }
   
    // MARK: - Actions

    @objc private func  dismissViewController() {
        dismiss(animated: true)
    }
    
}
