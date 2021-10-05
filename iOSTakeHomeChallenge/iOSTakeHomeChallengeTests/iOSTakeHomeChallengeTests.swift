//
//  iOSTakeHomeChallengeTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Muneer KK on 05/10/21.
//

import XCTest
@testable import iOSTakeHomeChallenge

class iOSTakeHomeChallengeTests: XCTestCase {

    var mockUrlSession: MockAPISession!
    var network: NetWorkManager!
    
    struct SomeIntResponse: Decodable {
        let someInt: Int
    }
    
    override func setUp() {
        mockUrlSession = MockAPISession()
        network = NetWorkManager()
    }
    
    func testDeserialiseBookData() throws {
        mockUrlSession.completeWithResponse = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)
        mockUrlSession.completeWithData = try JSONSerialization.data(withJSONObject: ["someInt": 120])
        
        network.makeRequest(url: URL(string: APIConstants.baseURL.appending(APIConstants.APIUrls.books.rawValue))!, type: [Book].self, completionHandler: { error, books in
            if let books = books {
                assert((books as Any) is [Book])
            }
        })
    }

}
