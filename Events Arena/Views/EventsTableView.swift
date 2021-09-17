//
//  EventsTableView.swift
//  Events Arena
//
//  Created by Nada Kamel on 18/09/2021.
//

import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier,
                                                 for: indexPath) as! EventsTableViewCell
        cell.configure(with: events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let viewController = ArticleDetailsViewController(with: viewModel.popularArticles[indexPath.row])
//        navigationController?.pushViewController(viewController, animated: false)
    }
    
}
