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
    
    func getEventTypes() {
        self.homeView?.startLoading()        
        homeService.getEventTypes( { [weak self] result in
            self?.homeView?.finishLoading()
            switch result {
            case .success(let types):
                if types.count == 0 {
                    self?.homeView?.setEmpty()
                } else {
                    self?.homeView?.setTypes(types)
                }
                break
            case .failure(let error):
                self?.homeView?.showErrorAlert(error.localizedDescription)
                break
            }
        })
    }
    
    func getEventListing(eventType: EventType, page: Int) {
        homeService.getEventListing(eventType, page: page) { [weak self] result in
            switch result {
            case .success(let eventDetails):
                self?.homeView?.setEvents(eventDetails)
                break
            case .failure(let error):
                self?.homeView?.showErrorAlert(error.localizedDescription)
                break
            }
        }
    }
    
}
