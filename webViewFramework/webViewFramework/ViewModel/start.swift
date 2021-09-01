//
//  start.swift
//  webViewFramework
//
//  Created by mac on 2021/07/02.
//

import Foundation

public func start(uID: String, pID: String , completionHandler: @escaping (Int) -> Void) {
    guard let encodedUid = uID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        print("encoding Fail")
        completionHandler(-1)
        return
    }
    
    guard let encodedPid = pID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        print("encoding Fail")
        completionHandler(-1)
        return
    }

    let endString = "?pid=\(encodedPid)&uid=\(encodedUid)&os=IOS&platform=APP"
    requestAPI().getPointRequest(with: requestAPI().pointBaseURL + endString) {(nPoint: Int) in
        
        completionHandler(nPoint)
    }
}
