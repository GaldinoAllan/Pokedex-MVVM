//
//  PokedexViewController.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import UIKit

class PokedexViewController: UIViewController {

    // MARK: - Views

    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(PokedexCell.self,
                           forCellReuseIdentifier: String(describing: PokedexCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()

    // MARK: - Properties

    private let viewModel: PokedexViewModel

    // MARK: - Initializers

    init(viewModel: PokedexViewModel = PokedexViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModel.loadPokedex()
    }

    // MARK: - Set Up methods

    private func setUp() {
        title = "Pokedex"
        setUpSubView()
        setUpConstraints()
        setUpDelegates()
    }

    private func setUpSubView() {
        view.addSubview(tableView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    private func setUpDelegates() {
        viewModel.delegate = self
    }

    // MARK: - Contents

    private func showAlert(with alertInfo: (title: String, message: String)) {
        let alert = UIAlertController(title: alertInfo.title,
                                      message: alertInfo.message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

// MARK: - PokedexViewModelDelegate

extension PokedexViewController: PokedexViewModelDelegate{
    func pokedexDidLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.activity.stopAnimating()
        }
    }

    func fetchFailed(withError errorInfo: (title: String, message: String)) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showAlert(with: errorInfo)
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension PokedexViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokedex.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: String(describing: PokedexCell.self),
                                     for: indexPath) as? PokedexCell else {
                    return UITableViewCell()
                }

        let pokemonInfo = viewModel.loadPokemon(with: viewModel.pokedex.results[indexPath.row].url)

        cell.pokemonName = pokemonInfo?.name
        cell.imageUrl = pokemonInfo?.imageUrl

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertInfo = viewModel.selectPokemonFromList(at: indexPath)
        showAlert(with: alertInfo)
    }
}
