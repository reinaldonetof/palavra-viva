//
//  BibleVersesTableViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 23/11/23.
//

import UIKit

class BookVersesTableViewController: UITableViewController {
    private var viewModel: BookVersesViewModel
    private var isShowing = false
    private var shouldReloadData = false
    
    lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init?(coder: NSCoder, book: Book, chapterSelected: Int) {
        viewModel = BookVersesViewModel(book: book, chapter: chapterSelected)
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl?.beginRefreshing()
        configObserver()
        viewModel.delegate = self
        viewModel.fetchVerses()
        setupOverlayView()
    }

    func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(VerseTableViewCell.nib(), forCellReuseIdentifier: VerseTableViewCell.identifier)
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func configObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeFontSize), name: .changeFontSize, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changePrimaryVersion), name: .changePrimaryVersion, object: nil)
    }
    
    @objc func changeFontSize() {
        if (isShowing) {
            tableView.reloadData()
        } else {
            shouldReloadData = true
        }
    }
    
    @objc func changePrimaryVersion() {
        viewModel.fetchVerses()
    }

    @objc private func refresh() {
        refreshControl?.beginRefreshing()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let button = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(navigateToEditPreference))
        navigationItem.rightBarButtonItem = button
        navigationController?.setNavigationBarHidden(false, animated: animated)
        isShowing = true
        if(shouldReloadData) {
            tableView.reloadData()
            shouldReloadData = false
        }
    }
    
    @objc func navigateToEditPreference() {
        let vcString = String(describing: UserPreferenceViewController.self)
        let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? UserPreferenceViewController
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        isShowing = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.getNumberOfRowsInSection()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VerseTableViewCell.identifier, for: indexPath) as? VerseTableViewCell
        cell?.setupCell(verse: viewModel.getVerseForRow(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.fetchSecondaryVersion(indexPath: indexPath)
    }
}

extension BookVersesTableViewController: BookVersesViewModelProtocol {
    func successRequestUniqueVerse(text: String) {
        print(text)
        overlayView.isHidden = false
    }
    
    func errorRequestUniqueVerse(error: Error) {
        Alert.setNewAlert(target: self, title: "Error ao capturar o verso", message: "Error: \(error.localizedDescription)")
    }
    
    func successRequest() {
        configTable()
    }

    func errorRequest(error: Error) {
        Alert.setNewAlert(target: self, title: "Error no request", message: "Error: \(error.localizedDescription)")
        refreshControl?.endRefreshing()
    }
}

extension BookVersesTableViewController {
    func setupOverlayView() {
           // Adiciona a view acima da UITableView
           view.addSubview(overlayView)

           NSLayoutConstraint.activate([
               overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               overlayView.heightAnchor.constraint(equalToConstant: 200)
           ])

           overlayView.isHidden = true
       }
}
