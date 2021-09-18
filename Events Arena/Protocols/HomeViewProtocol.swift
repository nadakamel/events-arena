//
//  HomeViewProtocol.swift
//  Events Arena
//
//  Created by Nada Kamel on 17/09/2021.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func startLoading()
    func finishLoading()
    func showErrorWith(message: String)
    func setTypes(_ eventTypes: EventTypes)
    func updateEvents(_ events: EventsDetails)
    func setEmptyEventsList()
    func loadMoreEvents()
    func navigateToEventDetails(_ event: EventDetails)
}
