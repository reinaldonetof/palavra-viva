//
//  HomeViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 13/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var list: [String] = [SearchTableViewCell.identifier, BooksTableViewCell.identifier]
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.register(BooksTableViewCell.nib(), forCellReuseIdentifier: BooksTableViewCell.identifier)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch list[indexPath.row] {
        case SearchTableViewCell.identifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell
            return cell ?? UITableViewCell()
        case BooksTableViewCell.identifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: BooksTableViewCell.identifier, for: indexPath) as? BooksTableViewCell
            cell?.setupCell(books: Books(title: "novo testamento", books: [Book(abbrev: Abbrev(pt: "as", en: "as") , author: "123", chapters: 1, group: "132", name: "123", testament: .nt)]))
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
