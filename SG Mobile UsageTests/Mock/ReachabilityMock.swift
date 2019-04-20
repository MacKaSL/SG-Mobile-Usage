//
//  ReachabilityMock.swift
//  SG Mobile UsageTests
//
//  Created by Himal Madhushan on 4/20/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import Reachability

class ReachabilityMock: Reachability {
    
    var reachableWifi = false
    var reachableWWAN = false
    
    override func isReachableViaWiFi() -> Bool {
        return reachableWifi
    }
    
    override func isReachableViaWWAN() -> Bool {
        return reachableWWAN
    }
}
