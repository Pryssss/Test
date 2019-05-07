
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
            url = URL(string: item.url!)
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
            
            if (UIImage(data: currentImage) != nil) {
                cellImageView.image = UIImage(data: currentImage)
                
            }
            titleLabel.text = model.title
            subtitleLabel.text = model.description
            data1Label.text = model.publishedAt
            data2Label.text = model.source!.name
        }
    }
}
