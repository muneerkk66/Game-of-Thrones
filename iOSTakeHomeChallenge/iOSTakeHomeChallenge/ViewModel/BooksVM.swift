//
//  BooksVM.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//

import Foundation
import UIKit

class BooksVM: NSObject, UITableViewDataSource {
    
    private var cachedBooks: [Book] = []
    private var filteredBooks: [Book] = []
    private let network = NetWorkManager()
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell") as! BooksTableViewCell
        cell.setupWith(book: cachedBooks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedBooks.count
    }
    
    func setupTableView(tableView: UITableView) {
        tableView.addBackground(imageName: "imgBooks")
        tableView.applyStyles()
    }
    
    func getData(isFiltered: Bool, searchText: String, completionHandler: @escaping (Bool) -> Void) {
        network.makeRequest(url: URL(string: AppConstants.baseURL.appending(AppConstants.APIUrls.books.rawValue))!, type: [Book].self, completionHandler: { [self] error, books in
            if let books = books {
                let filtered = books.filter {book in return book.name.contains(searchText)}
                cachedBooks = isFiltered ? filtered : books
                completionHandler(true)
            }
        })
    }
    
}
