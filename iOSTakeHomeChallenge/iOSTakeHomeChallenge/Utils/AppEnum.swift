//
//  AppEnum.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//

import Foundation

class AppEnum: NSObject {
    
    //MARK: Labels and constant strings
    enum Text: String {
        case unavailable = "Unavailable"
        case search = "Search"
    }

    enum ImageName: String {
        case charactersBG = "imgCharacters"
        case housesBG = "imgHouses"
        case booksBG = "imgBooks"
    }

    enum TableViewCellID: String {
        case books = "BooksTableViewCell"
        case houses = "HouseTableViewCell"
        case characters = "CharacterTableViewCell"
    }

}
