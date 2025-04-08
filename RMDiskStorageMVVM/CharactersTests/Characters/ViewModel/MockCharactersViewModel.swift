//
//  MockCharactersViewModel.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 08.04.2025.
//

import Foundation
@testable import RMDiskStorageMVVM

final class MockCharactersViewModel: CharactersViewModelProtocol {
    var characters: Observable<[Character]> = Observable([])

    private(set) var viewDidLoadCalled = false

    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func numberOfCharacters() -> Int {
        return characters.value.count
    }

    func character(at index: Int) -> Character {
        return characters.value[index]
    }
}
