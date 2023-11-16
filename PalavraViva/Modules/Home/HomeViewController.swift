//
//  HomeViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 13/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var tableView: UITableView!

    var viewModel: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.delegate = self
        viewModel.fetchBooks()
    }

    func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.register(BooksTableViewCell.nib(), forCellReuseIdentifier: BooksTableViewCell.identifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = viewModel.getListToShow()
        if list[indexPath.row].type == SearchTableViewCell.identifier {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell
            return cell ?? UITableViewCell()
        }
        if list[indexPath.row].type == BooksTableViewCell.identifier {
            let cell = tableView.dequeueReusableCell(withIdentifier: BooksTableViewCell.identifier, for: indexPath) as? BooksTableViewCell
            cell?.setupCell(books: list[indexPath.row].values as! Books)
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
}

extension HomeViewController: HomeViewModelProtocol {
    func errorRequest(error: Error) {
        Alert().setNewAlert(target: self, title: "Error no request", message: "Error: \(error)")
    }
    
    func successRequest() {
        configTable()
    }
}
