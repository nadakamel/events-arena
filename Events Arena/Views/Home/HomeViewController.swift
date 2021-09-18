//
//  HomeViewController.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    let _view = HomeView()
    let presenter = HomePresenter(homeService: HomeService())
    
    fileprivate var types = EventTypes()
    var events = EventsDetails()
    var pageNo: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setNavigationTitleView()
        
        presenter.attachView(false, view: self)
    
        _view.eventsTableView.delegate = self
        _view.eventsTableView.dataSource = self
        _view.delegate = self
        
        presenter.getEventTypes()
    }
    
    override func loadView() {
        super.loadView()
        view = _view
    }
    
    fileprivate func setNavigationTitleView() {
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Events", attributes:[
                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.bold),
                                                    NSAttributedString.Key.foregroundColor: ThemeManager.blueColor])
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
    
    func showAlert(title: String?, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeViewProtocol {
    func startLoading() {
        if(_view.refreshControl.isRefreshing) {
            events = []
        } else {
            _view.spinner.startAnimating()
        }
        _view.eventsTableView.reloadData()
    }

    func finishLoading() {
        _view.refreshControl.endRefreshing()
        _view.spinner.stopAnimating()
    }
    
    func showErrorWith(message: String) {
        showAlert(title: message)
    }
    
    func setTypes(_ eventTypes: EventTypes) {
        types = eventTypes
        events = []
        pageNo = 1
        for (index, _) in eventTypes.enumerated() {
            _view.segmentedControl.insertSegment(withTitle: eventTypes[index].name, at: index, animated: false)
            _view.segmentedControl.selectedSegmentIndex = 0
        }
        presenter.getEventListing(eventType: types[0], page: pageNo)
    }
    
    func updateEvents(_ events: EventsDetails) {
        self.events.append(contentsOf: events)
        _view.eventsTableView.reloadData()
    }
    
    func setEmptyEventsList() {
        _view.eventsTableView.backgroundView = _view.emptyTableViewLabel
        _view.eventsTableView.reloadData()
    }
    
    func loadMoreEvents() {
        presenter.getEventListing(eventType: types[_view.segmentedControl.selectedSegmentIndex], page: pageNo)
    }
    
    func navigateToEventDetails(_ event: EventDetails) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
        viewController.event = event
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension HomeViewController: HomeViewDelegate {
    func loadEvents(withTypeIndex index: Int) {
        _view.spinner.stopAnimating()
        events = []
        pageNo = 1
        presenter.getEventListing(eventType: types[index], page: pageNo)
    }
}
