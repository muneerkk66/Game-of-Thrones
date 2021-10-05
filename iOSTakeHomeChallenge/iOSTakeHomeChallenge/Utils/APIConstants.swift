
import Foundation

class APIConstants: NSObject {
    
    enum BaseURL: String {
        case production = "https://anapioficeandfire.com"
        case test = "https://anapioficeandfiretest.com"
    }
    
    // MARK: - Pointed Server
    static let baseURL = BaseURL.production.rawValue
    
    
    
    //MARK:  URLS
    enum APIUrls: String {
        case books = "/api/books"
        case houses = "/api/houses"
        case characters = "/api/characters"
    }
    
    
}
