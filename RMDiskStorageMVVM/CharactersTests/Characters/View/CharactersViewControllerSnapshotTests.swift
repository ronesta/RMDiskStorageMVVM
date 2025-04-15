//
//  CharactersViewControllerSnapshotTests.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 08.04.2025.
//

import XCTest
import SnapshotTesting
@testable import RMDiskStorageMVVM

final class CharactersViewControllerSnapshotTests: XCTestCase {
    func testCharactersViewControllerAppearance() {
        let viewModel = MockCharactersViewModel()
        let dataSource = MockDataSource(viewModel: viewModel)

        let viewController = CharactersViewController(viewModel: viewModel,
                                                      tableViewDataSource: dataSource
        )

        let navigationController = UINavigationController(rootViewController: viewController)

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

        viewModel.characters.value = characters
        viewController.loadViewIfNeeded()

        assertSnapshot(of: navigationController, as: .image)
    }
}
