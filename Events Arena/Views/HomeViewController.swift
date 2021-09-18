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
    fileprivate let presenter = HomePresenter(homeService: HomeService())
    
    fileprivate var types = EventTypes()
    var events = EventsDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setNavigationTitleView()
        
        presenter.attachView(false, view: self)
        
        _view.eventsTableView.delegate = self
        _view.eventsTableView.dataSource = self
        _view.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        _view.spinner.startAnimating()
    }

    func finishLoading() {
        _view.spinner.stopAnimating()
    }
    
    func showErrorAlert(_ message: String) {
        showAlert(title: message)
    }
    
    func setTypes(_ eventTypes: EventTypes) {
        types = eventTypes
    }
    
    func setEvents(_ events: EventsDetails) {
        self.events = events
        _view.eventsTableView.reloadData()
    }
    
    func setEmpty() {
        _view.eventsTableView.backgroundView = _view.emptyTableViewLabel
        _view.eventsTableView.reloadData()
    }
}

extension HomeViewController: HomeViewDelegate {
    func loadEvents(withTypeIndex index: Int) {
        presenter.getEventListing(eventType: types[index], page: 1)
    }
}
