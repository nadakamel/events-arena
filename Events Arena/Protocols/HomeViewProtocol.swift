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
    func setEvents(_ events: EventsDetails)
    func setEmptyEventTypes()
    func setEmptyEventsList()
    func navigateToEventDetails(_ event: EventDetails)
}
