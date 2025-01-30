//
//  CharacterViewModel.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 30.01.2025.
//

import Foundation

final class CharacterViewModel: CharacterViewModelProtocol {
    var characters: Observable<[Character]> = Observable([])
    private let networkManager: NetworkManagerProtocol?
    private let storageManager: StorageManagerProtocol?

    init(networkManager: NetworkManagerProtocol?,
         storageManager: StorageManagerProtocol?
    ) {
        self.networkManager = networkManager
        self.storageManager = storageManager
    }

    func getCharacters() {
        if let savedCharacters = storageManager?.loadCharacters() {
            characters.value = savedCharacters
            return
        }

        networkManager?.getCharacters { [weak self] result in
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    self?.characters.value = character
                    self?.storageManager?.saveCharacters(character)
                }
            case .failure(let error):
                print("Failed to fetch drinks: \(error.localizedDescription)")
            }
        }
    }

    func numberOfCharacters() -> Int {
        return characters.value.count
    }

    func character(at index: Int) -> Character {
        return characters.value[index]
    }
}
