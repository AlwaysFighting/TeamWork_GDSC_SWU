import UIKit

class AddTaskViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var AddTaskTextField: UITextField!
    @IBOutlet weak var xmarkButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var colorChartButton: UIButton!
    
    @IBOutlet weak var stepNumberTableView: UITableView!
    
    
    // Radiobutton Label
    private let sections: [String] = ["Step 1", "Step 2", "Step 3"]
    
    var isSelctedBtnNumber: Int!
    
    
    // MARK: - LisfeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorViewUI()
        configureNotificationObservers()
        delegateUI()
        defaultUI()
        
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func xmarkButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        print("doneButtonTapped")
    }
    
    @IBAction func colorChartTapped(_ sender: UIButton) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
    }
    

    @objc func textDidChange(sender: UITextField) {
        if sender == AddTaskTextField && AddTaskTextField.hasText{
            AddTaskTextField.Gounderlined()
            doneButton.setTitleColor(.TabColor, for: .normal)
            doneButton.isEnabled = true
        }else{
            AddTaskTextField.Nounderlined()
            doneButton.setTitleColor(.systemGray4, for: .normal)
            doneButton.isEnabled = false
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - Helpers
    
    func defaultUI(){
        doneButton.isEnabled = false
    
    }
    
    func delegateUI(){
        self.AddTaskTextField.delegate = self
        
        self.stepNumberTableView.delegate = self
        self.stepNumberTableView.dataSource = self
    }
    
    
    func colorViewUI(){
        
        // Keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // UI
        view.backgroundColor = .BackgroundColor
        AddTaskTextField.backgroundColor = .BackgroundColor
        colorChartButton.layer.cornerRadius = colorChartButton.frame.height/2
        colorChartButton.backgroundColor = .TabColor
        AddTaskTextField.setPlaceholder(color: .systemGray2)
        
        // TextField Style
        AddTaskTextField.becomeFirstResponder()
        AddTaskTextField.Nounderlined()
    }
    
    // textfield Changed?
    func configureNotificationObservers() {
            AddTaskTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

}

// MARK: - UIColorPickerViewControllerDelegate

extension AddTaskViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let colour = viewController.selectedColor as UIColor
        self.colorChartButton.backgroundColor = colour
    }
}

// MARK: - UITextFieldDelegate

extension AddTaskViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        AddTaskTextField.resignFirstResponder()
        AddTaskTextField.Nounderlined()
        return true
    }
}

// MARK: - UITableViewDataSource

extension AddTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension AddTaskViewController: UITableViewDelegate {
    
}

