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

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
  
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
