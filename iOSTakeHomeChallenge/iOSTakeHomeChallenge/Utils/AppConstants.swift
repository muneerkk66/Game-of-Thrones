//
//  AppConstants.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//

import Foundation

class AppConstants: NSObject {
    
    enum BaseURL: String {
        case production = "https://anapioficeandfire.com"
        case test = "https://anapioficeandfiretest.com"
    }
    
    // MARK: - Pointed Server
    static let baseURL = BaseURL.production.rawValue
    
    
    enum APIUrls: String {
        case books = "/api/books"
        case houses = "/api/houses"
        case characters = "/api/characters"
    }
}
