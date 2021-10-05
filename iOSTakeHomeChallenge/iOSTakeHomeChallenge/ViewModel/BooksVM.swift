//
//  BooksVM.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//

import Foundation
import UIKit

class BooksVM: NSObject, UITableViewDataSource, UISearchBarDelegate {
    
    private var cachedBooks: [Book] = []
    private var filteredBooks: [Book] = []
    private let network = NetWorkManager()
    
    func setupTableView(tableView: UITableView) {
        tableView.addBackground(imageName: AppEnum.ImageName.booksBG.rawValue)
        tableView.applyStyles()
    }
    
    func setupSearchBar(searchBar: UISearchBar) {
        searchBar.delegate = self
        searchBar.addStyles()
        searchBar.placeholder = AppEnum.Text.search.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppEnum.TableViewCellID.books.rawValue) as! BooksTableViewCell
        cell.setupWith(book: cachedBooks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedBooks.count
    }
    
    func getData(isFiltered: Bool, searchText: String, completionHandler: @escaping (Bool) -> Void) {
        network.makeRequest(url: URL(string: APIConstants.baseURL.appending(APIConstants.APIUrls.books.rawValue))!, type: [Book].self, completionHandler: { [self] error, books in
            if let books = books {
                let filtered = books.filter {book in return book.name.lowercased().contains(searchText.lowercased())}
                cachedBooks = isFiltered ? filtered : books
                completionHandler(true)
            }
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text
        guard searchText!.isEmpty || searchText == "" else {
            getData(isFiltered: true, searchText: searchText!, completionHandler:  {_ in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filteredBooks"), object: nil)
            })
            return
        }
        
        getData(isFiltered: false, searchText: "", completionHandler:  {_ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filteredBooks"), object: nil)
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
