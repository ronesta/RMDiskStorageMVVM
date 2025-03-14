//
//  CharacterViewModelProtocol.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 30.01.2025.
//

import Foundation

protocol CharactersViewModelProtocol {
    var characters: Observable<[Character]> { get set }

    func viewDidLoad()
    func numberOfCharacters() -> Int
    func character(at index: Int) -> Character
}
