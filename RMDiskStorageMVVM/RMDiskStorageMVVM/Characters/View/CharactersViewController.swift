//
//  ViewController.swift
//  RMDiskStorageMVVM
//
//  Created by Ибрагим Габибли on 24.01.2025.
//

import UIKit
import SnapKit

final class CharactersViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = "charactersTableView"
        return tableView
    }()

    private let viewModel: CharactersViewModelProtocol
    private let tableViewDataSource: CharactersDataSourceProtocol

    init(viewModel: CharactersViewModelProtocol, tableViewDataSource: CharactersDataSourceProtocol) {
        self.viewModel = viewModel
        self.tableViewDataSource = tableViewDataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupBindings()
        viewModel.viewDidLoad()
    }

    private func setupNavigationBar() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = tableViewDataSource
        tableView.register(CharactersTableViewCell.self,
                           forCellReuseIdentifier: CharactersTableViewCell.id)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupBindings() {
        viewModel.characters.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        128
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
