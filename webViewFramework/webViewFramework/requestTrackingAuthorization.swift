//
//  requestTrackingAuthorization.swift
//  webViewFramework
//
//  Created by mac on 2021/06/24.
//

import AppTrackingTransparency

func requestTA() {
    ATTrackingManager.requestTrackingAuthorization { (status) in
//        switch status {
//        case .authorized:
//            print("authorized")
//        case .denied:
//            print("denied")
//        case .notDetermined:
//            print("notDetermined")
//        case .restricted:
//            print("restricted")
//        }
    }

}

