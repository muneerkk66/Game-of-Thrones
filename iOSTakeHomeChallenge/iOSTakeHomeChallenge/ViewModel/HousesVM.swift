//
//  BooksVM.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//
import UIKit
class HousesVM: NSObject, UITableViewDataSource, UISearchBarDelegate {
    
    private var cachedHouses: [House] = []
    private let network = NetWorkManager()
    
    func setupSearchBar(searchBar: UISearchBar) {
        searchBar.delegate = self
        searchBar.addStyles()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cachedHouses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell") as! HouseTableViewCell
        cell.setupWith(house: cachedHouses[indexPath.row])
        return cell
    }

    func getData(isFiltered: Bool, searchText: String, completionHandler: @escaping (Bool) -> Void) {
        network.makeRequest(url: URL(string: AppConstants.baseURL.appending(AppConstants.APIUrls.houses.rawValue))!, type: [House].self, completionHandler: { [self] error, houses in
            if let houses = houses {
                let filtered = houses.filter {house in return house.name.contains(searchText)}
                cachedHouses = isFiltered ? filtered : houses
                completionHandler(true)
            }
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text
        guard searchText!.isEmpty || searchText == "" else {
            getData(isFiltered: true, searchText: searchText!, completionHandler:  {_ in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filteredHouses"), object: nil)
            })
            return
        }
        getData(isFiltered: false, searchText: "", completionHandler:  {_ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filteredHouses"), object: nil)
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
