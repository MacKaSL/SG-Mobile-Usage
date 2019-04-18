//
//  Constants.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/17/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Foundation

struct Constants {
    
    static let apiBaseURL = "https://data.gov.sg"
    
    struct CodingKey {
        static let resourceID = "resource_id"
        static let limit = "limit"
        static let offset = "offset"
        static let result = "result"
        static let records = "records"
        static let id = "_id"
        static let volume = "volume_of_mobile_data"
        static let quarter = "quarter"
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct AlertMessage {
    typealias AlertTuple = (title: String, message: String)
    static let noInternet: AlertTuple = ("No Internet", "App requires a working internet connection, which you don't have at the moment")
}
