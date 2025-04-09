//
//  MockDataSource.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 08.04.2025.
//

import UIKit
@testable import RMDiskStorageMVVM

final class MockDataSource: NSObject, CharactersDataSourceProtocol {
    var didCallReloadData: (() -> Void)?

    private(set) var viewModel: CharactersViewModelProtocol

    init(viewModel: CharactersViewModelProtocol) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCharacters()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharactersTableViewCell.id,
            for: indexPath
        ) as? CharactersTableViewCell else {
            return UITableViewCell()
        }

        let character = viewModel.character(at: indexPath.row)

        let viewModel = CharactersCellViewModel(character: character, image: nil)
        cell.configure(with: viewModel)

        return cell
    }

    func reloadData() {
        didCallReloadData?()
    }
}
