//
//  EventsTableView.swift
//  Events Arena
//
//  Created by Nada Kamel on 18/09/2021.
//

import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.black
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier,
                                                 for: indexPath) as! EventsTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: events[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = events.count - 1
        if indexPath.section == lastElement {
            if pageNo < 3 {
                pageNo+=1
                print("Page: \(pageNo)")
                addActivityIndicatorToLoadMore()
                loadMoreEvents()
                
            } else {
                _view.eventsTableView.tableFooterView = nil
            }
        }
    }

    private func addActivityIndicatorToLoadMore() {
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicatorView.frame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 40.0))
        activityIndicatorView.backgroundColor = UIColor.clear
        activityIndicatorView.color = ThemeManager.blueColor
        activityIndicatorView.startAnimating()
        _view.eventsTableView.tableFooterView = activityIndicatorView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.onEventSelected(details: events[indexPath.section])
    }
}
