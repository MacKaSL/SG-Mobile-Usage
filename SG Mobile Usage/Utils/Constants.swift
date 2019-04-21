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
    static let timeoutTime: Double = 20.0
    
    struct JSONKey {
        static let resourceId = "resource_id"
        
        static let result = "result"
        static let records = "records"
        
        static let volume = "volume_of_mobile_data"
        static let quarter = "quarter"
        static let id = "_id"
        
        static let limit = "limit"
        static let offset = "offset"
    }
    
    struct ErrorCode {
        static let domain = "com.sgmobileusage.networkerror"
        static let noResponse = 1000
        static let parsingFailed = 1001
        static let sessionFailed = 1002
        static let realmSaveFailed = 1003
        static let realmUpdateFailed = 1004
        static let realmDeleteFailed = 1005
        static let realmDeleteAllFailed = 1006
        static let noRecordsFoundInJson = 1007
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum DataUsageError: Error {
    case invalidJSON
    case invalidNumberOfQuaters
}

struct AlertMessage {
    typealias AlertTuple = (title: String, message: String)
    static let noInternet: AlertTuple = ("No Internet", "App requires a working internet connection, which you don't have at the moment")
}
