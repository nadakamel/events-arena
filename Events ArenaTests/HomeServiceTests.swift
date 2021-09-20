//
//  HomeServiceTests.swift
//  Events ArenaTests
//
//  Created by Nada Kamel on 20/09/2021.
//

@testable import Events_Arena
import XCTest

class HomeServiceTests: XCTestCase {

    private var service: HomeService!
    
    private var fetchedEventTypes: EventTypes?
    private var fetchedEvents: EventsDetails?
    private var fetchedError: Error?
    
    func testEventTypesRetrieved() {
        givenAHomeService()
        whenTheServiceTryToRetrieveEventTypes { [unowned self] eventTypesExpectation in
            thenTheEventTypesIsRetrieved(types: fetchedEventTypes, expectation: eventTypesExpectation)
        }
        thenTheServiceFinishedToTryToRetrieve(error: fetchedError)
    }
    
    func testEventsForSportsRetrieved() {
        if let type = fetchedEventTypes?[0] {
            testEventsForTypeRetrieved(type)
        }
    }
    
    private func testEventsForTypeRetrieved(_ type: EventType) {
        givenAHomeService()
        whenTheServiceTryToRetrieveEventsForType(type) { [unowned self] eventsForTypeExpectation in
            thenTheEventsForTypeIsRetrieved(events: fetchedEvents, expectation: eventsForTypeExpectation)
        }
        thenTheServiceFinishedToTryToRetrieve(error: fetchedError)
    }
    
    private func givenAHomeService() {
        service = HomeService()
    }
    
    private func whenTheServiceTryToRetrieveEventTypes(finish: @escaping (XCTestExpectation) -> Void) {
        let expectation = expectation(description: "EventTypesExpectation")
        service.getEventTypes { [unowned self] result in
            switch result {
            case .success(let types):
                fetchedEventTypes = types
            case .failure(let error):
                fetchedError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }

    private func thenTheEventTypesIsRetrieved(types: EventTypes?, expectation: XCTestExpectation) {
        XCTAssertNotNil(types)
        XCTAssertTrue(types!.count > 0)
    }
    
    private func whenTheServiceTryToRetrieveEventsForType(_ type: EventType, finish: @escaping (XCTestExpectation) -> Void) {
        let expectation = expectation(description: "EventsForTypeExpectation")
        service.getEventListing(type, page: 1) { [unowned self] result in
            switch result {
            case .success(let events):
                fetchedEvents = events
            case .failure(let error):
                fetchedError = error
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    private func thenTheEventsForTypeIsRetrieved(events: EventsDetails?, expectation: XCTestExpectation) {
        XCTAssertNotNil(events)
        XCTAssertTrue(events!.count > 0)
    }

    private func thenTheServiceFinishedToTryToRetrieve(error: Error?) {
        if let err = error {
            XCTAssertNil(error, "service should not return an error")
            XCTFail("Service finish() not called: \(err.localizedDescription)")
        }
    }
    
}
