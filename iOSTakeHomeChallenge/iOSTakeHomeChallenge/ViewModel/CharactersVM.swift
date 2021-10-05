//
//  BooksVM.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//

import UIKit

class CharactersVM: NSObject, UITableViewDataSource, UISearchBarDelegate {
    
    private var cachedCharacters: [Character] = []
    private let network = NetWorkManager()
    
    func setupSearchBar(searchBar: UISearchBar) {
        searchBar.delegate = self
        searchBar.addStyles()
        searchBar.placeholder = "Search"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.setupWith(character: cachedCharacters[indexPath.row])
        return cell
    }
    
    func getData(isFiltered: Bool, searchText: String, completionHandler: @escaping (Bool) -> Void) {
        network.makeRequest(url: URL(string: AppConstants.baseURL.appending(AppConstants.APIUrls.characters.rawValue))!, type: [Character].self, completionHandler: { [self] error, characters in
            if let characters = characters {
                let filtered = characters.filter {character in return character.name.contains(searchText)}
                cachedCharacters = isFiltered ?  filtered : characters
                completionHandler(true)
            }
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text
        guard searchText!.isEmpty || searchText == "" else {
            getData(isFiltered: true, searchText: searchText!, completionHandler:  {_ in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filteredCharacters"), object: nil)
            })
            return
        }
        getData(isFiltered: false, searchText: "", completionHandler:  {_ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filteredCharacters"), object: nil)
        })
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
