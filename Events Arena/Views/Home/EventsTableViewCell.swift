//
//  EventsTableViewCell.swift
//  Events Arena
//
//  Created by Nada Kamel on 18/09/2021.
//

import UIKit
import Kingfisher

class EventsTableViewCell: UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.textColor = ThemeManager.pinkColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        eventImageView.kf.cancelDownloadTask()
        eventImageView.image = nil
    }
    
    func configure(with event: EventDetails) {
        if let mediaURL = event.cover {
            eventImageView.kf.indicatorType = .activity
            eventImageView.kf.setImage(with: URL(string: mediaURL))
        }
        
        nameLabel.text = event.name
        
        locationLabel.text = "(\(event.latitude ?? ""), \((event.longitude ?? "")))"
    
        startDateLabel.text = "Starts on \(event.startDate?.toDate()?.toString() ?? "")"
        
        endDateLabel.text = "Ends on \(event.endDate?.toDate()?.toString() ?? "")"
    }
    
}
