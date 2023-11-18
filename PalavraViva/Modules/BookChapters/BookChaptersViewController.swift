//
//  BookChaptersViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 18/11/23.
//

import UIKit

class BookChaptersViewController: UIViewController {

    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: BookChaptersViewModel?
    
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
        guard let book = viewModel?.getBook() else { return }
        
        bookNameLabel.text = book.name
         
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
