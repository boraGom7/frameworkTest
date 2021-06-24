//
//  getUrl.swift
//  webViewFramework
//
//  Created by mac on 2021/06/16.
//

import UIKit

extension webViewController {
    
    func goWeb(str: String) {
        guard let encodedStr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("encoding Fail")
            return
        }
        print(encodedStr)
        //pid: 전달받은거 넣기
        //idfa: 사용자가 허용한 경우 넣기
        //http://external-api.oneplatform.kr/offerwall/views/nmp?pid=1&uid=1&os=IOS&platform=APP
        guard let url = URL(string: "https://m.naver.com") else {
            print("not valid URL")
            return
        }
        let request = URLRequest(url: url)
        //self.webView?.allowsBackForwardNavigationGestures = true
        self.webView?.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        self.webView?.load(request)
    }
    
    func getStrData(str: String) {
        self.searchStr = str
        return
    }
    
}
