//
//  BooksViewController.swift
//  iOSTakeHomeChallenge
//
//  Created on 09/03/2021.
//
import Foundation
import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    private let viewModel = BooksVM()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable), name: Notification.Name("filteredBooks"), object: nil)
        
        tableView.dataSource = viewModel
        viewModel.setupTableView(tableView: tableView)
        viewModel.setupSearchBar(searchBar: searchBar)
        
        navigationItem.titleView = searchBar
        viewModel.getData(isFiltered: false, searchText: "", completionHandler:  {_ in
            DispatchQueue.main.async {
                self.reloadTable()
            }
        })
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    @objc private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func hideKeyboard() {
        searchBar.endEditing(true)
    }
}
