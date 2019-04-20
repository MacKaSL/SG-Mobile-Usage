//
//  MockSession.swift
//  SG Mobile UsageTests
//
//  Created by Himal Madhushan on 4/20/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Foundation
@testable import SG_Mobile_Usage

class MockSession: URLSession {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        
        return MockSessionDataTask {
            completionHandler(data, response, error)
        }
    }
}

class MockSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() { closure() }
}


// MARK: - APIURL
protocol APIURLAccessible {
    var completedURL : String { get }
}


enum APIURL: APIURLAccessible {
    case invalid
    case dataUsage
    
    var completedURL: String {
        switch self {
        case .invalid:
            return "testInvalid"
            
        case .dataUsage:
            return Constants.apiBaseURL.appending("/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f")
        }
    }
}
