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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func reloadData() {
        didCallReloadData?()
    }
}
