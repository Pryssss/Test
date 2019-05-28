//
//  DataTableViewCell.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/27/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
    

    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        dataView.layer.cornerRadius = 20
        dataView.layer.masksToBounds = true
        
        titleLabel.font = Theme.Font.regular(size: 17)
        subtitleLabel.font = Theme.Font.regular(size: 17)
        dateLabel.font = Theme.Font.regular(size: 17)
        authorLabel.font = Theme.Font.regular(size: 17)
    }
    
        func setup(data: Article) {
            titleLabel.text = data.title
            subtitleLabel.text = data.description
            dateLabel.text = "Published at: \(AppDateFormatter.stringDate(from: data.publishedAt, format: .display))"
            authorLabel.text = "Source: \(data.source.name)"
            
            var commingData: Data? = nil
            if data.imageURL != nil {
                do {
                    commingData = try? Data(contentsOf: data.imageURL!)
                }
            }
            
            guard let currentImage = commingData else {
                photoImageView.image = nil
                imageViewHeightConstraint.constant = 0
                return
            }
            
            if (UIImage(data: currentImage) != nil) {
                photoImageView.image = UIImage(data: currentImage)
            }
            
            /// Reset back to zero in case the cell getting dequed had rounded corners.
//            cellView.layer.cornerRadius = 0
//            dataView.layer.cornerRadius = 0
//            bottomConstraint.constant = 0
        }
        
//        func roundBottomCorners() {
//            cellView.layer.cornerRadius = 10
//            cellView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//            dataView.layer.cornerRadius = 10
//            dataView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//            bottomConstraint.constant = 2
//        }
}


// -------------------------------------
// MARK: - spacing beetween cells
// -------------------------------------

extension DataTableViewCell {
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
}
