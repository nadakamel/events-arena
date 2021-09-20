//
//  HomeView.swift
//  Events Arena
//
//  Created by Nada Kamel on 18/09/2021.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func loadEvents(withTypeIndex index: Int)
}

class HomeView: UIView {

    weak var delegate: HomeViewDelegate?
    
    fileprivate let segmentedControlView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = ThemeManager.pinkColor
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.apportionsSegmentWidthsByContent = true
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    let eventsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.black
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 15
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var emptyTableViewLabel: UILabel = {
        let label = UILabel(frame: eventsTableView.frame)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = UIColor.white
        label.text = "No events found"
        return label
    }()
    
    let refreshControl = UIRefreshControl()
    
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupViewsConstraints() {
        NSLayoutConstraint.activate([
            segmentedControlView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControlView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: segmentedControlView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: segmentedControlView.trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: segmentedControlView.bottomAnchor),
            
            eventsTableView.topAnchor.constraint(equalTo: segmentedControlView.bottomAnchor, constant: 10),
            eventsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            eventsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            eventsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupUI() {
        segmentedControlView.addSubview(segmentedControl)
        [segmentedControlView, eventsTableView].forEach {
            self.addSubview($0)
        }
        setupViewsConstraints()
    }

    @objc private func refreshData(_ sender: Any) {
        delegate?.loadEvents(withTypeIndex: segmentedControl.selectedSegmentIndex)
    }
    
    private func setupTableView() {
        eventsTableView.register(EventsTableViewCell.nib,
                                   forCellReuseIdentifier: EventsTableViewCell.identifier)
        refreshControl.tintColor = ThemeManager.blueColor
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes:[
                                                                NSAttributedString.Key.foregroundColor: ThemeManager.blueColor])
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        eventsTableView.refreshControl = refreshControl
        eventsTableView.addSubview(refreshControl)
    }
    
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = ThemeManager.pinkColor
        eventsTableView.backgroundView = spinner
        
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTableView()
        setupSpinner()
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func segmentedValueChanged(_ sender: UISegmentedControl) {
        refreshControl.endRefreshing()
        delegate?.loadEvents(withTypeIndex: segmentedControl.selectedSegmentIndex)
    }

}
