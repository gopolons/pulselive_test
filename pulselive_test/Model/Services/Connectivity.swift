//
//  Connectivity.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 22/11/2021.
//

import Foundation
import Alamofire

//  Struct that allows to check whether connection exists via alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        return self.sharedInstance.isReachable
    }
}
