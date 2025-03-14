//
//  NetworkManagerProtocol.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 30.01.2025.
//

import Foundation

protocol CharactersServiceProtocol {
    func getCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}
