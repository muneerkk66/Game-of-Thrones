//
//  CharactersViewController.swift
//  iOSTakeHomeChallenge
//
//  Created on 09/03/2021.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    private let viewModel = CharactersViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable), name: Notification.Name("filteredCharacters"), object: nil)
        
        tableView.dataSource = viewModel
        tableView.allowsSelection = false
        tableView.addBackground(imageName: "imgCharacters")

        navigationItem.titleView = searchBar
        viewModel.getData(isFiltered: false, searchText: "", completionHandler:  {_ in
            DispatchQueue.main.async {
                self.reloadTable()
            }
        })
        
      
    }
    
    @objc private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
