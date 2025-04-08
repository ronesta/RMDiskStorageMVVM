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
    private var mockService: MockCharactersServiceForViewModel!
    private var mockStorageManager: MockStorageManager!

    override func setUp() {
        super.setUp()
        mockService = MockCharactersServiceForViewModel()
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

    func testViewDidLoadWhenCharactersAreSaved() {
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

        viewModel.viewDidLoad()

        XCTAssertEqual(viewModel.numberOfCharacters(), savedCharacters.count)
        XCTAssertEqual(viewModel.character(at: 0).name, "Summer Smith")
        XCTAssertEqual(viewModel.character(at: 1).name, "Beth Smith")
    }

    func testViewDidLoadWhenCharactersAreNotSaved() {
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

        mockService.characters = fetchedCharacters

        viewModel.viewDidLoad()

        XCTAssertEqual(viewModel.numberOfCharacters(), fetchedCharacters.count)
        XCTAssertEqual(viewModel.character(at: 0).name, "Rick Sanchez")
        XCTAssertEqual(viewModel.character(at: 1).name, "Morty Smith")
        XCTAssertFalse(mockService.shouldReturnError)
        XCTAssertEqual(mockStorageManager.characters, fetchedCharacters)
    }

    func testGetCharactersFailureShowsError() {
        mockService.shouldReturnError = true

        viewModel.viewDidLoad()

        XCTAssertEqual(viewModel.numberOfCharacters(), 0)
    }
}
