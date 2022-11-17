import UIKit

class PostViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var closeButton: UIButton!
    
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Actions
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
    // MARK: - Helper

    func configureUI() {
        // 색상 설정
        view.backgroundColor = .BackgroundColor
        tabBarController?.tabBar.isHidden = true
     
    }
    
    

}
