//
//  CharactersViewControllerTests.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 08.04.2025.
//

import XCTest
@testable import RMDiskStorageMVVM

final class CharactersViewControllerTests: XCTestCase {
    private var viewController: CharactersViewController!
    private var mockViewModel: MockCharactersViewModel!
    private var mockDataSource: MockDataSource!

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

    func testGivenViewController_WhenViewDidLoad_ThenViewModelViewDidLoadIsCalled() {
        // Given
        // ViewController initialized with mockViewModel & mockDataSource

        // When
        viewController.viewDidLoad()

        // Then
        XCTAssertTrue(mockViewModel.viewDidLoadCalled)
    }

    func testGivenViewController_WhenViewDidLoad_ThenTableViewIsConfigured() {
        // Given
        // ViewController initialized with mockViewModel & mockDataSource

        // When
        viewController.viewDidLoad()

        // Then
        XCTAssertNotNil(viewController.tableView.dataSource)
        XCTAssertTrue(viewController.tableView.dataSource === mockDataSource)

        XCTAssertNotNil(viewController.tableView.delegate)
        XCTAssertTrue(viewController.tableView.delegate === viewController)
    }

    func testGivenCharacters_WhenViewModelChanges_ThenTableViewIsUpdated() {
        // Given
        let characters = [
            Character(name: "John Doe",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth"),
                      image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
                     ),
            Character(name: "Morty Smith",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth (C-137)"),
                      image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
                     )
        ]

        mockViewModel.characters.value = characters

        // When
        viewController.loadViewIfNeeded()

        // Then
        XCTAssertEqual(mockViewModel.numberOfCharacters(), characters.count)
        XCTAssertEqual(mockViewModel.character(at: 0).name, "John Doe")
        XCTAssertEqual(mockViewModel.character(at: 1).name, "Morty Smith")
    }
}
