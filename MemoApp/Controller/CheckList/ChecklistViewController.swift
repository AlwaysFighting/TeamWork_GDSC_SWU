import UIKit

class ChecklistViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    
    // Identifier
    private let topReuseIdentifier = "TopBtnCell"
    private let StepOnetableReuseIdentifer = "CheckListCell"
   
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
        
        // collectionView dataSource
        self.collectionView.dataSource = self
        
        // Tableview dataSource
        self.stepsTableview.dataSource  = self
        
    }
    
    
    // MARK: - Helpers

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
    
    
}

extension ChecklistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: topReuseIdentifier, for: indexPath)
        
        stepScrollView.resizeScrollViewContentSize()
        collectionCell.backgroundColor = .red
        return collectionCell
    }
    
}

// MARK: - UITableViewDataSource

extension ChecklistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableView.isScrollEnabled = true
        
        let tableCell = UITableViewCell()
        tableCell.textLabel?.text = "TableView row \(indexPath.row) and \(tableView.contentSize.height)"
        tableCell.selectionStyle = .none
        tableCell.backgroundColor = .BackgroundColor
       
        
        return tableCell
    }

}
