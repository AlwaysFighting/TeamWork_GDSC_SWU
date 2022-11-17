import UIKit

class SettingViewController: UIViewController {
   
    // MARK: - Properties

    @IBOutlet weak var settingsTableView: UITableView!
    
    var settingArray: [Setting] = []
    var settingDataManager = SettingCellDataManger()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.rowHeight = 48
        
        settingDataManager.makeSettingData()
        settingArray = settingDataManager.getSettingData()
        
        settingsTableView.reloadData()
    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .BackgroundColor
        settingsTableView.backgroundColor = .BackgroundColor
        
        self.title = "설정"
        
    }

}

extension  SettingViewController:UITableViewDataSource, UITableViewDelegate{
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        
        let setting = settingArray[indexPath.row]
        
        cell.mainLabel.text = setting.settingText
        cell.mainImageIcon.image = setting.settingImage
        cell.mainImageIcon.tintColor = .TextColor
        cell.backgroundColor = .BackgroundColor
        
        cell.selectionStyle = .none
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.shadowColor = UIColor.gray.withAlphaComponent(0.6).cgColor
//        cell.layer.shadowOffset = CGSizeMake(5 , 7)
        cell.backgroundColor = .white
        settingsTableView.separatorStyle = .singleLine
        settingsTableView.rowHeight = 48
        settingsTableView.tintColor = .TextColor
        
       return cell
    }
}
