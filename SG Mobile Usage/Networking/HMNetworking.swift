//
//  HMNetworking.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/17/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Foundation
import Reachability

typealias SuccessCompletionBlock = (_ result: Any?) -> Void
typealias FailureCompletionBlock = (_ error: NSError?) -> Void
typealias Parameters = [String: AnyHashable]

class HMNetworking {
    
    static let shared = HMNetworking()
    var reachabilityManager: Reachability
    var isReachable: Bool {
        return reachabilityManager.isReachableViaWiFi() || reachabilityManager.isReachableViaWWAN()
    }
    var urlSession: URLSession
    
    private init() {
        self.urlSession = URLSession.shared
        self.reachabilityManager = Reachability.forInternetConnection()
    }
    
    /// Request that matches for all and encodes accoording to the method
    ///
    /// - Parameters:
    ///   - apiURL: APIURL.completedURL
    ///   - method: HTTPMethod
    ///   - parameters: Parameters
    ///   - headers: HMHeaders
    ///   - completion: Completion block for success or failure
    func request(_ apiURL: APIURL, method: HTTPMethod, parameters: Parameters? = nil, success: @escaping SuccessCompletionBlock, failure: @escaping FailureCompletionBlock) {
        
        guard HMNetworking.shared.isReachable else {
            Helper.showAlert(title: AlertMessage.noInternet.title, message: AlertMessage.noInternet.message)
            return
        }
        
        guard let url = URL.init(string: apiURL.completedURL) else { return }
        
        var urlRequest = URLRequest.init(url:url,
                                         cachePolicy: .useProtocolCachePolicy,
                                         timeoutInterval:20.0)
        urlRequest.httpMethod = method.rawValue
        
        if parameters != nil {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
        }
        
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                if let urlResponse = response as? HTTPURLResponse {
                    // Check if API call was successful
                    if urlResponse.statusCode == 200 {
                        if let responseData = data {
                            do {
                                // JSON serialization
                                let jsonObject = try JSONSerialization.jsonObject(with: responseData,
                                                                                  options: JSONSerialization.ReadingOptions.mutableContainers)
                                success(jsonObject)
                                
                            } catch let error as NSError {
                                // JSON serialization failed
                                let error = ErrorParser.parsed(error.localizedDescription, errorCode: Constants.ErrorCode.parsingFailed)
                                failure(error)
                            }
                        }
                    } else {
                        let localizedError = HTTPURLResponse.localizedString(forStatusCode: urlResponse.statusCode)
                        let error = ErrorParser.parsed(localizedError, errorCode: urlResponse.statusCode)
                        failure(error)
                    }
                } else {
                    // No response from server
                    let error = ErrorParser.parsed("No response received from server", errorCode: Constants.ErrorCode.noResponse)
                    failure(error)
                }
            } else {
                // URL session error
                let error = ErrorParser.parsed(error!.localizedDescription, errorCode: Constants.ErrorCode.sessionFailed)
                failure(error)
            }
        }
        dataTask.resume()
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
            return Constants.apiBaseURL.appending("/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f")
        }
    }
}

// MARK: - HMHeaders
struct HMHeaders {
    static let contentTypeJSON: [String: String] = ["Content-Type": "application/json"]
    static let contentTypeXForm: [String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
    static let accept: [String: String] = ["Accept": "application/json"]
}


struct ErrorParser {
    static func parsed(_ errorMessage: String, errorCode: Int) -> NSError {
        let error = NSError.init(domain: Constants.ErrorCode.domain, code: errorCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        return error
    }
}
