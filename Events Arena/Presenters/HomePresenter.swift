//
//  HomePresenter.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation

class HomePresenter {
    
    // MARK: - Private
    fileprivate let homeService: HomeService
    weak fileprivate var homeView: HomeViewProtocol?
    
    init(homeService: HomeService) {
        self.homeService = homeService
    }
    
    func attachView(_ attach: Bool, view: HomeViewProtocol?) {
        if attach {
            homeView = nil
        } else {
            if let view = view { homeView = view }
        }
    }
    
    func loadCachedEventTypes() {
        guard let types = RealmHelper.getRealmEventTypes() else { return }
        homeView?.setTypes(types)
    }
    
    func getEventTypes() {
        self.homeView?.startLoading()        
        homeService.getEventTypes( { [weak self] result in
            self?.homeView?.finishLoading()
            switch result {
            case .success(let types):
                self?.homeView?.setTypes(types)
                break
            case .failure(let error):
                self?.homeView?.showErrorWith(message: error.localizedDescription)
                break
            }
        })
    }
    
    func loadCachedEvents(withType eventType: EventType) {
        guard let eventsDetails = RealmHelper.getRealmEventsDetails(withType: eventType) else {
            homeView?.setEmptyEventsList()
            return }
        homeView?.updateEvents(eventsDetails)
    }
    
    func getEventListing(eventType: EventType, page: Int) {
        self.homeView?.startLoading()
        homeService.getEventListing(eventType, page: page) { [weak self] result in
            self?.homeView?.finishLoading()
            switch result {
            case .success(let events):
                if events.count == 0 {
                    self?.homeView?.setEmptyEventsList()
                } else {
                    self?.homeView?.updateEvents(events)
                }
                break
            case .failure(let error):
                self?.homeView?.showErrorWith(message: error.localizedDescription)
                break
            }
        }
    }
    
    public func onEventSelected(details: EventDetails) {
        self.homeView?.navigateToEventDetails(details)
    }
    
}
