//
//  BookChaptersViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 18/11/23.
//

import UIKit

class BookChaptersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: BookChaptersViewModel
    
    init?(coder: NSCoder, book: Book) {
        self.viewModel = BookChaptersViewModel(book: book)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configElements()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configElements() {
        let book = viewModel.getBook()
        title = book.name
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ChaptersTableViewCell.nib(), forCellReuseIdentifier: ChaptersTableViewCell.identifier)
    }
}

extension BookChaptersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = viewModel.getListToShow()
        if list[indexPath.row].type == ChaptersTableViewCell.identifier {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChaptersTableViewCell.identifier, for: indexPath) as? ChaptersTableViewCell
            cell?.delegate = self
            cell?.setupCell(book: list[indexPath.row].values as! Book)
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
}

extension BookChaptersViewController:  ChaptersTableViewCellProtocol {
    func didSelectChapter(chapter: Int) {
        let vcString = String(describing: BibleVersesTableViewController.self)
        let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? BibleVersesTableViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
}
