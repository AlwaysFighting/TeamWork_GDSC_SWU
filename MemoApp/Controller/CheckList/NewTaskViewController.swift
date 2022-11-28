import UIKit
import Combine
import ContextMenuSwift

class NewTaskViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var addNewTaskTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewBottomConstaint: NSLayoutConstraint!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var stepNumberButton: UIButton!
    @IBOutlet weak var palateButton: UIButton!
    

    private var subscribers = Set<AnyCancellable>()
    @Published private var taskString: String?
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupGesture()
        observeKeyboard()
        observeForm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addNewTaskTextField.becomeFirstResponder()
    }
    
    private func observeForm() {
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).map({
            ($0.object as? UITextField)?.text
        }).sink { [unowned self] (text) in
            self.taskString = text
        }.store(in: &subscribers)
        
        $taskString.sink { [unowned self] (text) in
            self.saveButton.isEnabled = text?.isEmpty == false
        }.store(in: &subscribers)
   
    }
    
    private func setUpView() {
        containerView.layer.cornerRadius = 20
        backgroundView.backgroundColor = UIColor.init(white: 0.3, alpha: 0.4)
        containerViewBottomConstaint.constant = -containerView.frame.height
        addNewTaskTextField.keyboardAppearance = .default
        addNewTaskTextField.setPlaceholder(color: .systemGray2)
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func getKeyboardHeight(notification: Notification) -> CGFloat {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return 0}
        return keyboardHeight
    }
    
    // MARK: - Actions
    
    @IBAction func colorPalateButtonTapped(_ sender: Any) {
        print("colorPalateButtonTapped")
    }
    
    @IBAction func stepButtonTapped(_ sender: UIButton) {
        print("stepButtonTapped")
        let step1 = ContextMenuItemWithImage(title: "Step1", image: .checkmark)
        let step2 = ContextMenuItemWithImage(title: "Step2", image: .checkmark)
        let step3 = ContextMenuItemWithImage(title: "Step3", image: .checkmark)
        
        CM.items = [step1, step2, step3]
        CM.showMenu(viewTargeted: saveButton, delegate: self, animated: true)
    }
    
    
    @IBAction func saveChecklistButtonTapped(_ sender: Any) {
        print("saveChecklistButtonTapped")
    }
    
    
    @objc func keyboardWillShow(_ notification : Notification) {
        let keyboardHeight = getKeyboardHeight(notification: notification)
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [unowned self] in
            self.containerViewBottomConstaint.constant = keyboardHeight - (200 + 8)
            self.view.layoutIfNeeded()
        },completion: nil)
    }
    
    @objc func keyboardWillHide(_ notification : Notification) {
        containerViewBottomConstaint.constant = -containerView.frame.height
    }
    
    @objc private func  dismissViewController() {
        dismiss(animated: true)
    }

}


extension NewTaskViewController: ContextMenuDelegate {
    func contextMenuDidSelect(_ contextMenu: ContextMenuSwift.ContextMenu, cell: ContextMenuSwift.ContextMenuCell, targetedView: UIView, didSelect item: ContextMenuSwift.ContextMenuItem, forRowAt index: Int) -> Bool {
        return true
    }
    
    func contextMenuDidDeselect(_ contextMenu: ContextMenuSwift.ContextMenu, cell: ContextMenuSwift.ContextMenuCell, targetedView: UIView, didSelect item: ContextMenuSwift.ContextMenuItem, forRowAt index: Int) {
        
    }
    
    func contextMenuDidAppear(_ contextMenu: ContextMenuSwift.ContextMenu) {
        
    }
    
    func contextMenuDidDisappear(_ contextMenu: ContextMenuSwift.ContextMenu) {
        
    }
    
    
}
