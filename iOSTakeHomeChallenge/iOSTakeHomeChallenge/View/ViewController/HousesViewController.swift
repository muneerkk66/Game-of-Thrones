//
//  HousesViewController.swift
//  iOSTakeHomeChallenge
//
//  Created on 09/03/2021.
//

import Foundation
import UIKit

class HousesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    private let viewModel = HousesViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable), name: Notification.Name("filteredHouses"), object: nil)
        
        tableView.addBackground(imageName: "imgHouses")
        tableView.dataSource = viewModel
        tableView.allowsSelection = false
        
        navigationItem.titleView = searchBar
        viewModel.getData(isFiltered: false, searchText: "", completionHandler: {_ in  DispatchQueue.main.async {
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
