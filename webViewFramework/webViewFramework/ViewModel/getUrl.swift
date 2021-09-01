//
//  getUrl.swift
//  webViewFramework
//
//  Created by mac on 2021/06/16.
//

import UIKit

extension webViewController {
    
    func goWeb(uID: String, pID: String, idfa: String) {
        guard let encodedUid = uID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("encoding Fail")
            return
        }
        
        guard let encodedPid = pID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("encoding Fail")
            return
        }
        
        guard let encodedIdfa = idfa.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("encoding Fail")
            return
        }
        guard let url = URL(string: "https://external-api.oneplatform.kr/offerwall/views/nmp?pid=\(encodedPid)&uid=\(encodedUid)&idfa=\(encodedIdfa)&os=IOS&platform=APP") else {
            print("not valid URL")
            return
        }
        let request = URLRequest(url: url)
        self.webView?.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        self.webView?.load(request)
    }
    
    func goRedirectUrl(url: String) {
        guard let url = URL(string: url) else {
            print("not valid URL")
            return
        }
        let request = URLRequest(url: url)
        self.webView?.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        self.webView?.load(request)
    }
    
    func getStrData(uID: String, pID: String, age: String, gender: String) {
        self.uID = uID
        self.pID = pID
        self.gender = gender
        self.age = age
        return
    }
    
}
