//
//  requestTrackingAuthorization.swift
//  webViewFramework
//
//  Created by mac on 2021/06/24.
//

import AppTrackingTransparency
import AdSupport

func requestTA(completionHandler: @escaping (String) -> Void){
    if #available(iOS 14, *) {
        ATTrackingManager.requestTrackingAuthorization { (status) in
            
            switch status {
            case .authorized:
                print("authorized")
                completionHandler(getIDFA())
            case .denied:
                print("denied")
                completionHandler("nil")
            case .notDetermined:
                print("notDetermined")
                completionHandler("nil")
            case .restricted:
                print("restricted")
                completionHandler("nil")
            }
            
        }
    } else {
        
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            completionHandler(getIDFA())
        } else {
            completionHandler("nil")
        }
    }
    
}

func getIDFA() -> String {
    print("getIDFA")
    print(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
    return ASIdentifierManager.shared().advertisingIdentifier.uuidString
}

