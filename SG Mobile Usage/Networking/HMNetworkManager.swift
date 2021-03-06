//
//  HMNetworkManager.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/18/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Foundation

class HMNetworkManager {
    
    static func fetchDataUsage(success: @escaping (([AnualDataUsageRecord]) -> Void), failure: @escaping FailureCompletionBlock) {
        HMNetworking.shared.request(.dataUsage, method: .get, success: { (results) in
            if let resp = results as? [String: Any], let json = resp[Constants.JSONKey.result] as? [String: Any] {
                do {
                    try RealmManager.removeAll(AnualDataUsageRecord.self)
                    let usageResponse = try DataUsageResponseHandler.init(json)
                    success(usageResponse.anualUsage)
                } catch {
                    failure(ErrorParser.parsed("Could not load usage data.", errorCode: Constants.ErrorCode.noRecordsFoundInJson))
                }
            }
        }) { (error) in
            failure(error)
        }
    }
    
}
