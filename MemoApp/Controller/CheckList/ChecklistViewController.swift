import UIKit

class ChecklistViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    
    // Identifier
    private let topReuseIdentifier = "CheckoutCollectionViewCell"
    private let SteptableReuseIdentifer = "CheckListOneCell"
    private let showNewTask = "showNewTask"
    private let editNewTask = "editNewTask"
    private let showNewDetailCheckList = "showNewDetailCheckList"
    
    // Define the array to use in the Table.
    //private let iOSItems: [String] = ["iOS12", "iOS11", "iOS10", "iOS9", "iOS8", "iOS7"]
    private let AOSItems: [String] = ["9.x", "8.x", "7.x", "6.x"]
    
    // Define the array to be used in Section.
    private let sections: [String] = ["Step 1", "Step 2", "Step 3"]
    
    // 테이블뷰의 데이터를 표시하기 위한 배열
    var makeCollectionTextArray: [systemMaekCollectionViewData] = []
    var CheckCollectionDataManager = ChecklistCollectionDataManager()
    
    // collectionView 마지막 열 구하기
    var collectionCount : Int = 0
    
    // collectionView 현재 페이지가 어딘지 알기
    var collectionCurrentPage: Int = 0
    
    // longPressGesture
    var longPressGesture: UILongPressGestureRecognizer!
   
    // PostButton
    @IBOutlet weak var PostButton: UIButton!
    
    // collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    // stepTableview
    @IBOutlet weak var stepsTableview: UITableView!
    
    // stepScrollView
    @IBOutlet weak var stepScrollView: UIScrollView!
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        dataSourceCollection()
        cheklistCollectionUI()
        setuplongPressMove()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        stepScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: stepsTableview.contentSize.height + 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    // MARK: - Helpers
    
    func showSimpleActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: .none, message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (_) in
            print("User click Edit button")
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("User click Delete button")
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    // 태그가 10개 이상으로 추가하려고 하면 나오는 경고창
    func showErrorMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // 태그 추가하기
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "태그 추가하기", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                // operations
                print("Text==>" + text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Tag"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    private func cheklistCollectionUI() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func dataSourceCollection() {
        // collectionView dataSource
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Tableview dataSource
        self.stepsTableview.dataSource  = self
        
        self.stepsTableview.allowsSelection = false
        
        // stepsTableview Cell Drag & Drop
        self.stepsTableview.dragInteractionEnabled = true
        self.stepsTableview.dragDelegate = self
        self.stepsTableview.dropDelegate = self
        
        CheckCollectionDataManager.makeCollectionData()
        makeCollectionTextArray = CheckCollectionDataManager.getMakeCollectionData()
    }
    
    private func setuplongPressMove(){
        
    }

    func configureUI() {
        
        // 색상 설정
        view.backgroundColor = .BackgroundColor
        stepScrollView.backgroundColor = .BackgroundColor
        tabBarController?.tabBar.tintColor = .TabColor
        collectionView.backgroundColor = .BackgroundColor
        PostButton.tintColor = .TabColor
        stepsTableview.backgroundColor = .BackgroundColor
        
        // 네비게이션 타이틀 변경
        self.title = "체크리스트"
        
        // PostButton UI 변경
        PostButton.layer.cornerRadius = 28
        PostButton.layer.borderWidth = 0.1
        PostButton.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        PostButton.backgroundColor = .white
        PostButton.layer.shadowOpacity = 0.18
        PostButton.layer.shadowColor = UIColor.gray.withAlphaComponent(0.6).cgColor
        PostButton.layer.shadowOffset = CGSizeMake(5 , 7)
        
    }
    
    // MARK: - Actions
    
    @IBAction func taskPostButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: showNewTask, sender: nil)
    }
    
    @IBAction func checkBoxTableButtonTapped(_ sender: UIButton) {
        print("checkBoxTableList")
    }
    
    @IBAction func editTableButtonTapped(_ sender: Any) {
        print("editTableButtonTapped")
        
        
    }
    
    
}


// MARK: - UICollectionViewDelegate

// 데이터 소스 설정
extension ChecklistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("click index=\(indexPath.row)")
        
        let cell  = collectionView.cellForItem(at: indexPath) as! CheckoutCollectionViewCell
        
        collectionCurrentPage = indexPath.row
        
        // MARK: - ❗️문구 다시 변경하기.. 좀 이상
        
        if(indexPath.row + 1 == 11) {
            if(collectionCount == 11) {
                cell.contentView.backgroundColor = .systemGray4
                cell.contentView.layer.borderColor = UIColor.systemGray3.cgColor
                cell.checkListLabel.textColor = .TextColor
                showErrorMessage(withTitle: "Error", message: "태그는 10개까지만 가능합니다.")
            }
        } else if (indexPath.row == collectionCount - 1) {
            cell.contentView.backgroundColor = .systemGray4
            cell.contentView.layer.borderColor = UIColor.systemGray3.cgColor
            cell.checkListLabel.textColor = .TextColor
            showAlertWithTextField()
        }else {
            cell.isSelected = true
        }
    
    }
    
}

// MARK: - UICollectionViewDataSource

// 액션과 관련된 것들
extension ChecklistViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return makeCollectionTextArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = String(describing: CheckoutCollectionViewCell.self)
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CheckoutCollectionViewCell
        
        let checkCollectionData = makeCollectionTextArray[indexPath.row]
        collectionCell.checkListLabel.text = checkCollectionData.makeCollectionText
        
        
        // collectionCell UI
        
        if(collectionCell.checkListLabel.text?.count == 1) {
            collectionCell.contentView.layer.masksToBounds = true
            collectionCell.contentView.layer.cornerRadius = 5.0
            
        }else {
            collectionCell.contentView.layer.cornerRadius = 17
        }
    
        let totalRows = collectionView.numberOfItems(inSection: indexPath.section)
        collectionCount = totalRows
      
        if(indexPath.row == collectionCount - 1) {
            collectionCell.contentView.backgroundColor = .systemGray4
            collectionCell.contentView.layer.borderColor = UIColor.systemGray3.cgColor
            collectionCell.contentView.layer.borderColor = UIColor.systemGray3.cgColor
        } else {
            collectionCell.contentView.backgroundColor = .BackgroundColor
            collectionCell.contentView.layer.borderColor = UIColor.TabColor?.cgColor
        }
            
        collectionCell.contentView.layer.borderWidth = 1
        
        return collectionCell
    }
}

extension ChecklistViewController:UITableViewDelegate {
    
    // Row Editable true
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Move Row Instance Method
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        let moveCell = self.makeCollectionTextArray[sourceIndexPath.row]
        self.makeCollectionTextArray.remove(at: sourceIndexPath.row)
        self.makeCollectionTextArray.insert(moveCell, at: destinationIndexPath.row)
    }
    
}


// MARK: - UITableViewDataSource

extension ChecklistViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.isScrollEnabled = false
        let tableCell = tableView.dequeueReusableCell(withIdentifier: SteptableReuseIdentifer) as! CheckListOneCell
        
        tableCell.selectionStyle = .none
        
        tableCell.backgroundColor = .BackgroundColor
        
        tableCell.layer.masksToBounds = true
        tableCell.layer.cornerRadius = 10
        tableCell.layer.borderWidth = 1
        // tableCell.layer.shadowOffset = CGSize(width: 1, height: 1)
        tableCell.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.1).cgColor
        return tableCell
    }
}

// MARK: - Talbeview Drag and Drop
extension ChecklistViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }

}

extension ChecklistViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
    
}
