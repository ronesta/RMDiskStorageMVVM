//
//  CharactersViewControllerTests.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 08.04.2025.
//

import XCTest
@testable import RMDiskStorageMVVM

final class CharactersViewControllerTests: XCTestCase {
    var viewController: CharactersViewController!
    var mockViewModel: MockCharactersViewModel!
    var mockDataSource: MockDataSource!

    override func setUp() {
        super.setUp()
        mockViewModel = MockCharactersViewModel()
        mockDataSource = MockDataSource(viewModel: mockViewModel)
        viewController = CharactersViewController(viewModel: mockViewModel,
                                                  tableViewDataSource: mockDataSource
        )
    }

    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        mockDataSource = nil
        super.tearDown()
    }

    func testViewDidLoadCallsViewModelViewDidLoad() {
        viewController.viewDidLoad()

        XCTAssertTrue(mockViewModel.viewDidLoadCalled)
    }

    func testSetupViews() {
        viewController.viewDidLoad()

        XCTAssertNotNil(viewController.tableView.dataSource)
        XCTAssertTrue(viewController.tableView.dataSource === mockDataSource)

        XCTAssertNotNil(viewController.tableView.delegate)
        XCTAssertTrue(viewController.tableView.delegate === viewController)
    }

//    func testTableViewReloadsWhenViewModelCharactersChanges() {
//        let expectation = expectation(description: "TableView Reloads")
//
//        mockDataSource.didCallReloadData = {
//            expectation.fulfill()
//        }
//        
//        mockViewModel.characters.value = [
//            Character(name: "John Doe",
//                      status: "Alive",
//                      species: "Human",
//                      gender: "Male",
//                      location: Location(name: "Earth"),
//                      image: "image_url"
//                     )
//        ]
//
//        wait(for: [expectation], timeout: 1.0)
//    }
}
