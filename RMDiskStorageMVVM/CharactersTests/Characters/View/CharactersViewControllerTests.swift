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
        mockDataSource = MockDataSource()
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
}
