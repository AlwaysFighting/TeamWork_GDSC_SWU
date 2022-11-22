import UIKit

class ListViewController: UIViewController {
    
   
    @IBOutlet weak var tableView: UITableView!
    

    
    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
    
    var token: NSObjectProtocol?
    
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        print(DataManager.shared.noteList)
        DataManager.shared.fetchNote()
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //        initRefresh()
    }
    
}
        
    // MARK: - Table view data source
extension  ListViewController: UITableViewDelegate, UITableViewDataSource {
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return DataManager.shared.noteList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            
            
            
            let target = DataManager.shared.noteList[indexPath.row]
            cell.textLabel?.text = target.content
            cell.detailTextLabel?.text = formatter.string(for: target.insertDate)
            
            
            if indexPath.row == 0 {
                cell.backgroundColor = .clear
                cell.textLabel?.textColor = .black
                
            }
            else {
                cell.backgroundColor = .clear
                cell.textLabel?.textColor = .black
            }
            
            return cell
        }
        
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            let target = DataManager.shared.noteList[indexPath.row]
            
            DataManager.shared.deleteNote(target)
            if editingStyle == .delete {
                tableView.deleteRows(at: [indexPath], with: .fade)
                guard let note = cell.textLabel?.text, note.count > 0 else {
                    return
                }
            }
        }
        
        
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "edit" {
                guard let nextViewController : EditNoteViewController = segue.destination as? EditNoteViewController else {
                    return
                }
                guard let cell : UITableViewCell = sender as? UITableViewCell else {
                    return
                }
                nextViewController.textToSet = cell.textLabel?.text
                nextViewController.dateToSet = cell.detailTextLabel?.text
            }
        }
        
    }
    
