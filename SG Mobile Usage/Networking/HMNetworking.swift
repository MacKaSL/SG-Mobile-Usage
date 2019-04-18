//
//  HMNetworking.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/17/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Foundation
import Reachability

typealias GenaralAPICompletionBlock = (_ success: Bool, _ result: Any?) -> Void
typealias Parameters = [String: AnyHashable]

class HMNetworking: NSObject {
    
    static let shared = HMNetworking()
    let reachabilityManager = Reachability.forInternetConnection()
    var isReachable: Bool {
        let reachability = Reachability()
        return reachability.isReachable()
    }
    static var headers = [String: String]()
    
    /// Request that matches for all and encodes accoording to the method
    ///
    /// - Parameters:
    ///   - apiURL: APIURL.completedURL
    ///   - method: HTTPMethod
    ///   - parameters: Parameters
    ///   - headers: HMHeaders
    ///   - completion: Completion block for success or failure
    static func request(_ apiURL: APIURL, method: HTTPMethod, parameters: Parameters? = nil, headers: [String: String] = HMNetworking.headers, completion: @escaping GenaralAPICompletionBlock) {
        
        guard HMNetworking.shared.isReachable else {
            Helper.showAlert(on: nil, title: AlertMessage.noInternet.title, message: AlertMessage.noInternet.message)
            return
        }
        
        guard let url = URL.init(string: apiURL.completedURL) else { return }
        
        _ = self.headers.add(other: HMHeaders.accept)
        _ = self.headers.add(other: HMHeaders.contentTypeJSON)
        
        print("##############  Calling URL: ", apiURL.completedURL)
        
        var urlRequest = URLRequest.init(url:url,
                                         cachePolicy: .useProtocolCachePolicy,
                                         timeoutInterval:20.0)
        
        urlRequest.httpMethod = method.rawValue
        if parameters != nil {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
        }
    }
    
}


// MARK: - Reachability
extension HMNetworking {
    static func setupReachability() {
        let manager = HMNetworking.shared.reachabilityManager
        manager?.startNotifier()
        manager?.unreachableBlock = { reachability in
            DispatchQueue.main.async {
                if let r = reachability, !r.isReachable() {
                    Helper.showAlert(on: nil, title: AlertMessage.noInternet.title, message: AlertMessage.noInternet.message)
                }
            }
        }
    }
}


// MARK: - APIURL
protocol APIURLAccessible {
    var completedURL : String { get }
}

enum APIURL: APIURLAccessible {
    case dataUsage
    
    var completedURL: String {
        switch self {
        case .dataUsage:
            return Constants.apiBaseURL.appending("/authentication/login")
        }
    }
}

// MARK: - HMHeaders
struct HMHeaders {
    static let contentTypeJSON: [String: String] = ["Content-Type": "application/json"]
    static let contentTypeXForm: [String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
    static let accept: [String: String] = ["Accept": "application/json"]
}
