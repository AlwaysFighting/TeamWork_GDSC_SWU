import UIKit


class CheckoutCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var checkListLabel: UILabel!
    
    var checkListCollection : String = "" {
        didSet {
            self.checkListLabel.text = checkListCollection
        }
    }
    
    override var isSelected: Bool {
           didSet{
               if isSelected {
                   contentView.layer.backgroundColor  = UIColor.TabColor?.cgColor
                   checkListLabel.font = UIFont.boldSystemFont(ofSize: 17)
                   checkListLabel.textColor = .white
               }
               else {
                   contentView.layer.borderColor = UIColor.TabColor?.cgColor
                   contentView.layer.backgroundColor  = UIColor.BackgroundColor?.cgColor
                   checkListLabel.font = UIFont.boldSystemFont(ofSize: 17)
                   checkListLabel.textColor = .TextColor
               }
           }
    }

    
    
    
}
