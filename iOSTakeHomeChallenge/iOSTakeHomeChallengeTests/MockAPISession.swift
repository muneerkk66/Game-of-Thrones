//
//  MockAPISession.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Muneer KK on 05/10/21.
//

import XCTest

class URLProtocolMock: URLProtocol {
    /// Dictionary maps URLs to tuples of error, data, and response
    static var mockURLs = [URL?: (error: Error?, data: Data?, response: HTTPURLResponse?)]()

    override class func canInit(with request: URLRequest) -> Bool {
        // Handle all types of requests
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        // Required to be implemented here. Just return what is passed
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let (error, data, response) = URLProtocolMock.mockURLs[url] {
                
                // We have a mock response specified so return it.
                if let responseStrong = response {
                    self.client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
                }
                
                // We have mocked data specified so return it.
                if let dataStrong = data {
                    self.client?.urlProtocol(self, didLoad: dataStrong)
                }
                
                // We have a mocked error so return it.
                if let errorStrong = error {
                    self.client?.urlProtocol(self, didFailWithError: errorStrong)
                }
            }
        }

        // Send the signal that we are done returning our mock response
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // Required to be implemented. Do nothing here.
    }
}

class MockAPISession: URLSession {
    var completeWithData: Data?
    var completeWithResponse: HTTPURLResponse?
    var completeWithError: Error?
    var getNextResponse: (URLRequest) -> HTTPURLResponse? = { _ in nil }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        let completeWithData = self.completeWithData
        let getNextResponse = self.getNextResponse
        let completeWithResponse = self.completeWithResponse
        let completeWithError = self.completeWithError

        return MockAPISessionDataTask {
            completionHandler(completeWithData, getNextResponse(request) ?? completeWithResponse, completeWithError)
        }
    }
}

class MockAPISessionDataTask: URLSessionDataTask {
    private let onResume: () -> Void

    init(onResume: @escaping () -> Void) {
        self.onResume = onResume
    }

    override func resume() {
        onResume()
    }

    override func cancel() {
    }
}

