import UIKit

protocol MyTableViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}

class ChecklistViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    
    // Identifier
    weak var delegate:MyTableViewCellDelegate?
    
    private let topReuseIdentifier = "CheckoutCollectionViewCell"
    private let SteptableReuseIdentifer = "CheckListOneCell"
    private let showNewTask = "showNewTask"
    private let editNewTask = "editNewTask"
    private let showNewDetailCheckList = "showNewDetailCheckList"
    
    // Define the array to be used in Section.
    private let sections: [String] = ["Step 1", "Step 2", "Step 3"]
    
    let step1 = ["유산소 운동 1시간"]
    let step2 = ["필라테스 한 달 이용", "헬스장 PT 한 달 이용"]
    let step3 = ["체지방률 XX 달성!"]
    
    // section 사이 간격 조정
    let cellSpacingHeight: CGFloat = 100
    
    // TableView 의 데이터를 표시하기 위한 배열
    var makeTableViewOneTextArray : [systemMakeTableStepOneViewData] = []
    var makeTableViewTwoTextArray : [systemMakeTableStepTwoViewData] = []
    var makeTableViewThreeTextArray : [systemMakeTableStepThreeViewData] = []
    var checkTableDataManager = ChecklistTableViewDataManager()
    
    // Collection 뷰의 데이터를 표시하기 위한 배열
    var makeCollectionTextArray: [systemMakeCollectionViewData] = []
    var CheckCollectionDataManager = ChecklistCollectionDataManager()
    
    // 테이블뷰 인덱스 알기
    var indexPathRow: Int  = 0
    
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
        hideKeyboarOnTap() 
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        stepScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: stepsTableview.contentSize.height + 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Helpers
    
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
        self.stepsTableview.delegate = self
        self.stepsTableview.allowsSelection = false
        
        // stepsTableview Cell Drag & Drop
        self.stepsTableview.dragInteractionEnabled = true
        self.stepsTableview.dragDelegate = self
        self.stepsTableview.dropDelegate = self
        self.stepsTableview.isUserInteractionEnabled = true
        self.stepsTableview.allowsSelection = true
        
        CheckCollectionDataManager.makeCollectionData()
        makeCollectionTextArray = CheckCollectionDataManager.getMakeCollectionData()
        
        checkTableDataManager.makeTableData()
        makeTableViewOneTextArray = checkTableDataManager.getMakeTableOneData()
        makeTableViewTwoTextArray = checkTableDataManager.getMakeTableTwoData()
        makeTableViewThreeTextArray = checkTableDataManager.getMakeTableThreeData()
        
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
    
    public func hideKeyboarOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboardAction() {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Actions
    
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func taskPostButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: showNewTask, sender: nil)
    }
    
    @IBAction func checkBoxTableButtonTapped(_ sender: UIButton) {
        print("checkBoxTableList")
    }
    
    @IBAction func editTableButtonTapped(_ sender: Any) {
    
        
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "Edit", style: .default, handler: { action in
            self.editButtonTapped()
        })
        
        let action = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteButtonTapped()
        })
        
        let cancle = UIAlertAction(title: "Cancle", style: .cancel)
        
        alert.addAction(edit)
        alert.addAction(action)
        alert.addAction(cancle)
        present(alert, animated: true, completion: nil)
    }
    
    // edit 눌렀을 때 action
    func editButtonTapped() {
        
        
    }
    
    // delete Button Tapped..
    func deleteButtonTapped() {
        
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

// MARK: - UITableViewDelegate

extension ChecklistViewController:UITableViewDelegate {
    
    // Row Editable true
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 센션별 간격 정하기
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(10)
    }

    // 셀 선택시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            print("didSelectRowAt \(indexPath.row) 1")
        }else if indexPath.section == 1 {
            print("didSelectRowAt \(indexPath.row) 2")
        }else {
            print("didSelectRowAt \(indexPath.row) 3")
        }
        
        indexPathRow = indexPath.row
        
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "Edit", style: .default, handler: { action in
            self.editButtonTapped()
        })
        
        let action = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            tableView.beginUpdates()
            
        })
        
        let cancle = UIAlertAction(title: "Cancle", style: .cancel)
        
        alert.addAction(edit)
        alert.addAction(action)
        alert.addAction(cancle)
        present(alert, animated: true, completion: nil)
        
    }
    
    // Move Row Instance Method
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        
        let moveCell = self.makeCollectionTextArray[sourceIndexPath.row]
        
        if sourceIndexPath.section == destinationIndexPath.section {
            self.makeCollectionTextArray.remove(at: sourceIndexPath.row)
            self.makeCollectionTextArray.insert(moveCell, at: destinationIndexPath.row)
        } else {
            self.makeCollectionTextArray.remove(at: sourceIndexPath.row)
            self.makeCollectionTextArray.insert(moveCell, at: destinationIndexPath.row)
        }
        
    }
    
    // 같은 섹션끼리만 이동 가능
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {

        let sourceSection = sourceIndexPath.section
        let destSection = proposedDestinationIndexPath.section

        if destSection < sourceSection {
            return IndexPath(row: 0, section: sourceSection)
        } else if destSection > sourceSection {
            return IndexPath(row: self.tableView(tableView, numberOfRowsInSection:sourceSection)-1, section: sourceSection)
        }

        return sourceIndexPath.section  == proposedDestinationIndexPath.section ? proposedDestinationIndexPath : sourceIndexPath
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
        // section 의 수대로 달라짐
        if section == 0 {
            return makeTableViewOneTextArray.count
        }else if section == 1{
            return makeTableViewTwoTextArray.count
        }else {
            return makeTableViewThreeTextArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let tableCell = tableView.dequeueReusableCell(withIdentifier: SteptableReuseIdentifer) as! CheckListOneCell
        
        tableView.isScrollEnabled = false
        
        if indexPath.section == 0 {
            let checkListOneData = makeTableViewOneTextArray[indexPath.row]
            tableCell.checkListTextView.text = checkListOneData.stepOneList
        } else if indexPath.section == 1 {
            let checkListTwoData = makeTableViewTwoTextArray[indexPath.row]
            tableCell.checkListTextView.text = checkListTwoData.stepTwoList
        }else {
            let checkListThreeData = makeTableViewThreeTextArray[indexPath.row]
            tableCell.checkListTextView.text = checkListThreeData.stepThreeList
        }
        
        
        // tableCell UI
        
        tableCell.selectionStyle = .none
        tableCell.backgroundColor = .BackgroundColor
        
        tableCell.layer.masksToBounds = true
        tableCell.clipsToBounds = true
        tableCell.layer.borderWidth = 1
        tableCell.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.1).cgColor
        tableCell.layer.cornerRadius = 10
       

        
        // tableCell.layer.shadowOffset = CGSize(width: 1, height: 1)
        
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
