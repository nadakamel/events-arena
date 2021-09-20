//
//  HomePresenterTests.swift
//  Events ArenaTests
//
//  Created by Nada Kamel on 20/09/2021.
//

@testable import Events_Arena
import XCTest

class HomePresenterTests: XCTestCase {
    
    private var serviceSpy: HomeServiceSpy!
    private var viewSpy: HomeViewSpy!
    private var presenter: HomePresenter!
        
    func testGetEventTypes() {
        givenAHomeServiceWithData()
        givenAHomeView()
        givenAHomePresenterWith(service: serviceSpy)
        whenHomePresenterGetsEventTypes()
        thenTryToRetrieveEventTypesFromServiceWithData()
    }

    func testGetEventListing() {
        givenAHomeServiceWithData()
        givenAHomeView()
        givenAHomePresenterWith(service: serviceSpy)
        whenHomePresenterGetsEventTypes()
        whenHomePresenterGetsEventsListing()
        thenTryToRetrieveEventTypesFromServiceWithData()
        thenTryToRetrieveEventsFromServiceWithData()
    }

    private func givenAHomeServiceWithData() {
        serviceSpy = HomeServiceSpy()
        serviceSpy.setFetchedData()
    }

    private func givenAHomeServiceWithoutData() {
        serviceSpy = HomeServiceSpy()
    }

    private func givenAHomeView() {
        viewSpy = HomeViewSpy()
    }

    private func givenAHomePresenterWith(service: HomeServiceSpy) {
        presenter = HomePresenter(homeService: service)
        presenter.attachView(false, view: viewSpy)
    }
    
    private func whenHomePresenterGetsEventTypes() {
        viewSpy.startLoading()
        presenter.getEventTypes()
        viewSpy.setTypes(serviceSpy.eventTypes)
    }
    
    private func whenHomePresenterGetsEventsListing() {
        viewSpy.startLoading()
        presenter.getEventListing(eventType: viewSpy.eventTypes[0], page: 1)
        viewSpy.updateEvents(serviceSpy.eventsDetails)
    }

    private func whenAnEventIsSelected(index: Int) {
        presenter.onEventSelected(details: serviceSpy.eventsDetails[index])
    }
    
    private func thenTheHomeViewStartsLoading() {
        XCTAssertTrue(viewSpy.isLoading)
    }
    
    private func thenTheHomeViewFinishLoading() {
        XCTAssertTrue(viewSpy.isLoading)
    }
    
    private func thenTryToRetrieveEventTypesFromServiceWithData() {
        XCTAssertTrue(viewSpy.eventTypes.count > 0)
    }
    
    private func thenTryToRetrieveEventTypesFromServiceWithoutData() {
        XCTAssertTrue(viewSpy.eventTypes.count == 0)
    }
    
    private func thenTryToRetrieveEventsFromServiceWithData() {
        XCTAssertTrue(viewSpy.eventsDetails.count > 0)
    }

    private func thenTryToRetrieveEventsFromServiceWithoutData() {
        XCTAssertTrue(viewSpy.eventsDetails.count == 0)
    }
    
    private func thenTheProductsViewShowsAnErrorMessage() {
        XCTAssertTrue(viewSpy.isThereError)
    }
    
}

class HomeViewSpy: HomeViewProtocol {
    
    var eventTypes = EventTypes()
    var eventsDetails = EventsDetails()
    var isLoading = false
    var isThereError = false
    
    func startLoading() {
        isLoading = true
    }
    
    func finishLoading() {
        isLoading = false
    }
    
    func showErrorWith(message: String) {
        isThereError = true
    }
    
    func setTypes(_ eventTypes: EventTypes) {
        finishLoading()
        isThereError = false
        self.eventTypes = eventTypes
    }
    
    func updateEvents(_ events: EventsDetails) {
        finishLoading()
        isThereError = false
        eventsDetails = events
    }
    
    func setEmptyEventsList() {
        finishLoading()
        isThereError = false
        eventsDetails = []
    }
    
    func loadMoreEvents() {
        startLoading()
        isThereError = false
    }
    
    func navigateToEventDetails(_ event: EventDetails) {
        isThereError = false
    }
    
}

class HomeServiceSpy: HomeService {
    
    var eventTypes = EventTypes()
    var eventsDetails = EventsDetails()
    
    func setFetchedData() {
        eventTypes = getEventTypes()
        eventsDetails = getEventListing()
    }
    
    func getEventTypes() -> EventTypes {
        let type = EventType()
        type.id = "5aa98d9fd7306cec6835667c"
        type.name = "Sports"
        return [type]
    }
    
    func getEventListing() -> EventsDetails {
        let event = EventDetails()
        event.latitude = "28.99553"
        event.longitude = "32.51794"
        event.endDate = "Saturday, December 3, 2016 8:50 AM"
        event.startDate = "Wednesday, September 7, 2016 3:29 PM"
        event.eventDetailDescription = "Living up to the challenges we face isn’t an edge to acquire but a necessity to live by. A startup, an individual, an investor or an entity, located in the MENA region or beyond, we were all faced by the same challenge"
        event.cover = "https://www.newstatesman.com/sites/all/themes/creative-responsive-theme/images/new_statesman_events.jpg"
        event.name = "BEFORE THE REVOLUTION"
        event.id = "BEFORE THE REVOLUTION"
        return [event]
    }
    
}
