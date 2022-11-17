import UIKit

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImageIcon: UIImageView!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

