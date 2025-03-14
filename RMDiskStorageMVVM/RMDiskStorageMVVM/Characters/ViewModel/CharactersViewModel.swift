//
//  CharacterViewModel.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 30.01.2025.
//

import Foundation

final class CharactersViewModel: CharactersViewModelProtocol {
    var characters: Observable<[Character]> = Observable([])

    private let charactersService: CharactersServiceProtocol
    private let storageManager: StorageManagerProtocol

    init(charactersService: CharactersServiceProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.charactersService = charactersService
        self.storageManager = storageManager
    }

    func viewDidLoad() {
        getCharacters()
    }

    private func getCharacters() {
        if let savedCharacters = storageManager.loadCharacters() {
            characters.value = savedCharacters
            return
        }

        charactersService.getCharacters { [weak self] result in
            switch result {
            case .success(let character):
                self?.characters.value = character
                self?.storageManager.saveCharacters(character)
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
