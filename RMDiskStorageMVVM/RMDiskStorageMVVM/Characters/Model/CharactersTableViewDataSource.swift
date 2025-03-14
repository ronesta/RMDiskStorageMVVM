//
//  CharacterTableViewDataSource.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 30.01.2025.
//

import Foundation
import UIKit

final class CharactersTableViewDataSource: NSObject, CharactersDataSourceProtocol {
    private let viewModel: CharactersViewModelProtocol
    private let imageLoader: ImageLoaderProtocol

    init(viewModel: CharactersViewModelProtocol,
         imageLoader: ImageLoaderProtocol
    ) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCharacters()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharactersTableViewCell.id,
            for: indexPath) as? CharactersTableViewCell else {
            return UITableViewCell()
        }

        let character = viewModel.character(at: indexPath.row)
        let imageURL = character.image

        imageLoader.loadImage(from: imageURL) { loadedImage in
            DispatchQueue.main.async {
                guard let cell = tableView.cellForRow(at: indexPath) as? CharactersTableViewCell  else {
                    return
                }

                let viewModel = CharactersCellViewModel(character: character, image: loadedImage)
                cell.configure(with: viewModel)
            }
        }

        return cell
    }
}
