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
        viewModel.delegate = self
        viewModel.fetchBooks()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
            guard let books = list[indexPath.row].values as? Books else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: BooksTableViewCell.identifier, for: indexPath) as? BooksTableViewCell
            cell?.delegate = self
            cell?.setupCell(books: books)
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

extension HomeViewController: BooksTableViewCellProtocol {
    func didSelectBook(book: Book) {
        let vcString = String(describing: BookChaptersViewController.self)
        let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(identifier: vcString) { coder -> BookChaptersViewController? in
            BookChaptersViewController(coder: coder, book: book)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
