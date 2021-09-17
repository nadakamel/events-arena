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
    
    fileprivate lazy var contentImageView: UIImageView = {
        let contentImageView = UIImageView()
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        contentImageView.layer.cornerRadius = 6
        contentImageView.layer.masksToBounds = true
        contentImageView.contentMode = .scaleToFill
        contentImageView.clipsToBounds = true
        return contentImageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.kf.cancelDownloadTask()
        contentImageView.image = nil
    }
    
    func configure(with event: EventDetails) {
        if let urlPath = event.cover {
            contentImageView.kf.setImage(with: URL(string: urlPath))
        } else {
            contentImageView.image = UIImage(named: "placeholder")
        }
        titleLabel.text = event.name
    }
    
}
