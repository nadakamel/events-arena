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
    func showErrorAlert(_ message: String)
    func setEvents(_ events: EventsDetails)
    func setTypes(_ eventTypes: EventTypes)
    func setEmpty()
}
