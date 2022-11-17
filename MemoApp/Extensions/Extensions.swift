import UIKit

// MARK: - UIColor

extension UIColor {

    // TabColor 
    class var TabColor: UIColor? { return UIColor(named: "TabColor") }
    
    class var Gray: UIColor? { return UIColor(named: "Gray") }
    
    class var TextColor: UIColor? { return UIColor(named: "TextColor") }
    
    class var BackgroundColor: UIColor? { return UIColor(named: "BackgroundColor") }
    
}

extension UIScrollView {
    
    func resizeScrollViewContentSize() {
        
        var contentRect = CGRect.zero
        
        for view in self.subviews {
            contentRect = contentRect.union(view.frame)
        }
        
        self.contentSize = contentRect.size
    }
}
