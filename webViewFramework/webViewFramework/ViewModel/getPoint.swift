//
//  getPoint.swift
//  webViewFramework
//
//  Created by mac on 2021/06/30.
//

import Foundation

var setPoint = 10 {
    didSet {
        getPoint()
    }
}

public func getPoint() -> Int {
    return setPoint
}
