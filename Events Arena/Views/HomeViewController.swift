//
//  HomeViewController.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    weak var eventsTableView: UITableView!
    weak var segmentedControl: UISegmentedControl!
    
    fileprivate let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    fileprivate let presenter = HomePresenter(homeService: HomeService())
    fileprivate var types: [String] = []
    fileprivate var events = EventsDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        addSpinnerView()
        
        presenter.attachView(false, view: self)
        
        configEventsTypeSegmentControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getEventTypes()
    }
    
    func addSpinnerView() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = ThemeManager.pinkColor
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func configEventsTypeSegmentControl() {
        let segmentedControl = UISegmentedControl(items: types)
        segmentedControl.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 30)
        segmentedControl.addTarget(self, action: Selector(("segmentedControlValueChanged")), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        eventsTableView.reloadData()
    }
    
    func configEventsTableView() {
        view.addSubview(eventsTableView)
    }
    
    func loadContentView(withTypes types: EventTypes) {
        let host = UIHostingController(rootView: HomeView(withEventTypes: types, homeService: HomeService()))
        guard let hostView = host.view else {
            return
        }
        hostView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostView)
        NSLayoutConstraint.activate([
            hostView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            hostView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension HomeViewController: HomeViewProtocol {
    func startLoading() {
        spinner.startAnimating()
    }

    func finishLoading() {
        spinner.stopAnimating()
    }
    
    func setTypes(_ eventTypes: EventTypes) {
        eventTypes.forEach { type in
            types.append(type.name ?? "")
        }
    }
    
    func setEvents(_ events: EventsDetails) {
        self.events = events
        eventsTableView.reloadData()
    }
    
    func setEmpty() {
        debugPrint("Empty list!")
    }
}
