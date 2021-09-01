//
//  parameters.swift
//  webViewFramework
//
//  Created by mac on 2021/06/29.
//

import Foundation

struct parameters: Codable {
    var result: String?
    var statusCode: String?
    var message: String?
    var data: data?
    
    struct data: Codable {
        var uid: String?
        var point: String?
    }
    
}

