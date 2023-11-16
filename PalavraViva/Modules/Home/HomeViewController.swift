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
    
    private var list: [String] = [SearchTableViewCell.identifier]
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if list[indexPath.row] == SearchTableViewCell.identifier {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
}
