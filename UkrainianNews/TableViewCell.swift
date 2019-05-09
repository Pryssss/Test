
import UIKit

class TableViewCell: UITableViewCell {
    
    var data: [News] = []
    
    @IBOutlet weak var blueButton: UIButtonX!
    
    @IBOutlet weak var imageStackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var data1Label: UILabel!
    @IBOutlet weak var data2Label: UILabel!
    
    @IBAction func buttonWasTapped(_ sender: Any) {
        var url: URL?
        for item in data {
            if let currentUrl = item.url {
                url = URL(string: currentUrl)
            }
        }
        if let currentUrl = url {
            UIApplication.shared.open(currentUrl, options: [:], completionHandler: nil)
        }
    }
    
    func setup(models: [News]) {
        blueButton.isEnabled = false
        
        data = models
        for model in models {
            var data: Data? = nil
            if model.urlToImage != nil {
                do {
                    data = try? Data(contentsOf: model.urlToImage!)
                }
            }
            
            guard let currentImage = data else {
                cellImageView.image = nil
                imageStackViewHeightConstraint.constant = 0
                return
            }
            guard let source = model.source?.name else { return }
            
            if (UIImage(data: currentImage) != nil) {
                cellImageView.image = UIImage(data: currentImage)
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            guard let safeDate = model.publishedAt else { return }
            let date = dateFormatter.date(from: safeDate)
            dateFormatter.dateStyle = .medium
            let dateString = dateFormatter.string(from: date!)
            
            titleLabel.text = model.title
            subtitleLabel.text = model.description
            data1Label.text = dateString
            data2Label.text = source
        }
    }
}
