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
            eventImageView.kf.setImage(with: URL(string: mediaURL))
        }
        
        nameLabel.text = event.name
        
        locationLabel.text = "Location: (\(event.latitude ?? ""), \((event.longitude ?? "")))"
    
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "EEEE, MMM d, yyyy h:mm a"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM, yyyy"
    
        var date: Date?
        if let startDate = event.startDate {
            date = dateFormatterGet.date(from: startDate)
            if let _date = date {
                startDateLabel.text = "Starts on \(dateFormatterPrint.string(from: _date))"
            }
        }
        
        if let endDate = event.endDate {
            date = dateFormatterGet.date(from: endDate)
            if let _date = date {
                endDateLabel.text = "Ends on \(dateFormatterPrint.string(from: _date))"
            }
        }
    }
    
}
