//
//  CharactersViewModelTests.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 08.04.2025.
//

import XCTest
@testable import RMDiskStorageMVVM

final class CharactersViewModelTests: XCTestCase {
    private var viewModel: CharactersViewModel!
    private var mockService: MockCharactersService!
    private var mockStorageManager: MockStorageManager!

    override func setUp() {
        super.setUp()
        mockService = MockCharactersService()
        mockStorageManager = MockStorageManager()
        viewModel = CharactersViewModel(
            charactersService: mockService,
            storageManager: mockStorageManager
        )
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockStorageManager = nil
        super.tearDown()
    }

    func testGivenSavedCharacters_WhenViewDidLoad_ThenCharactersAreDisplayedFromStorage() {
        // Given
        let savedCharacters = [
            Character(name: "Summer Smith",
                      status: "Alive",
                      species: "Human",
                      gender: "Female",
                      location: Location(name: "Earth (C-137)"),
                      image: "url_to_image"
                     ),
            Character(name: "Beth Smith",
                      status: "Alive",
                      species: "Human",
                      gender: "Female",
                      location: Location(name: "Earth (C-137)"),
                      image: "url_to_image"
                     )
        ]

        mockStorageManager.saveCharacters(savedCharacters)

        // When
        viewModel.viewDidLoad()

        // Then
        XCTAssertEqual(viewModel.numberOfCharacters(), savedCharacters.count)
        XCTAssertEqual(viewModel.character(at: 0).name, "Summer Smith")
        XCTAssertEqual(viewModel.character(at: 1).name, "Beth Smith")
    }

    func testGivenNoSavedCharacters_WhenViewDidLoad_ThenCharactersAreFetchedAndDisplayed() {
        // Given
        let fetchedCharacters = [
            Character(name: "Rick Sanchez",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth (C-137)"),
                      image: "url_to_image"
                     ),
            Character(name: "Morty Smith",
                      status: "Alive",
                      species: "Human",
                      gender: "Male",
                      location: Location(name: "Earth (C-137)"),
                      image: "url_to_image"
                     )

        ]

        mockService.stubbedCharactersResult = .success(fetchedCharacters)

        // When
        viewModel.viewDidLoad()

        // Then
        XCTAssertEqual(viewModel.numberOfCharacters(), fetchedCharacters.count)
        XCTAssertEqual(viewModel.character(at: 0).name, "Rick Sanchez")
        XCTAssertEqual(viewModel.character(at: 1).name, "Morty Smith")
        XCTAssertEqual(mockService.getCharactersCallCount, 1)
        XCTAssertEqual(mockStorageManager.characters, fetchedCharacters)
    }

    func testGivenServiceFailure_WhenViewDidLoad_ThenErrorIsDisplayed() {
        // Given
        let expectedError = NSError(domain: "Test", code: 0, userInfo: nil)
        mockService.stubbedCharactersResult = .failure(expectedError)

        // When
        viewModel.viewDidLoad()

        // Then
        XCTAssertEqual(mockService.getCharactersCallCount, 1)
        XCTAssertEqual(viewModel.numberOfCharacters(), 0)
    }
}
