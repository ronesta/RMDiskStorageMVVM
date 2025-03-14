//
//  CharacterAssembly.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 30.01.2025.
//

import Foundation
import UIKit

struct CharactersAssembly {
    func createModule() -> UIViewController {
        let storageManager = DiskStorageManager()
        let charactersService = CharactersService()
        let imageLoader = ImageLoader(storageManager: storageManager)

        let charactersViewModel = CharactersViewModel(
            charactersService: charactersService,
            storageManager: storageManager
        )

        let tableViewDataSource = CharactersTableViewDataSource(
            viewModel: charactersViewModel,
            imageLoader: imageLoader
        )

        let viewController = CharactersViewController(
            viewModel: charactersViewModel,
            tableViewDataSource: tableViewDataSource
        )

        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
