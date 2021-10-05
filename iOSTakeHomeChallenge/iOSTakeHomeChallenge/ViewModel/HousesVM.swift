//
//  BooksVM.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//
import UIKit
class HousesViewModel: NSObject, UITableViewDataSource {
    
    private var cachedHouses: [House] = []
    private let network = NetWorkManager()
    
    
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
}

