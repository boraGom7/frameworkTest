//
//  requestAPI.swift
//  webViewFramework
//
//  Created by mac on 2021/06/29.
//

import Foundation

class requestAPI {
    let uInfoBaseURL: String = "https://menteoff.net/97f7577a14b744989ae69028635b04c5"
    let pointBaseURL: String = "https://external-api.oneplatform.kr/api/v1/offerwall/point"
    var point: Int = 0 {
        didSet {
            setPoint = point
        }
    }
    
    func getPointRequest(with urlString: String, completionHandler: @escaping (Int) -> Void){
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let data = data else { return }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let message = json["message"] as? String {
                        if let dic = json["data"] as? Dictionary<String, Any> {
                            self.point = dic["point"] as! Int
                            
                            completionHandler(self.point)
                        }
                    }
                }
                
            }).resume()
        }
    }
    
    func getUInfoRequest(idfa: String, gender: String, age: String) {
        let dataObject: [String: Any] = ["media_idx": 338, "os": "ios", "device_id": idfa, "gender": gender, "birthday": age]
        
        if let url = URL(string: uInfoBaseURL) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("gzip", forHTTPHeaderField: "Content-Encoding")
            request.addValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let jsonData = try? JSONSerialization.data(withJSONObject: dataObject, options: [])
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
            
            let compressedData = try? jsonData?.gzipped()
            
            let base64Data = compressedData?.base64EncodedString()
            
            let decoded64Data = Data(base64Encoded: base64Data!, options: [])
            let decompressedData = try? decoded64Data?.gunzipped()
            
            let bodyObject: [String: Any] = ["data": base64Data!]
            let bodyData = try? JSONSerialization.data(withJSONObject: bodyObject, options: [])
            let bodyJson = try? JSONSerialization.jsonObject(with: bodyData!, options: [])
            request.httpBody = bodyData

            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let data = data else { return }

                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print(json)
                }
            }).resume()
        }
    }
}

extension String {
    func urlSafeBase64Decoded() -> String? {
        var st = self
            .replacingOccurrences(of: "_", with: "/")
            .replacingOccurrences(of: "-", with: "+")
        let remainder = self.count % 4
        if remainder > 0 {
            st = self.padding(toLength: self.count + 4 - remainder,
                              withPad: "=",
                              startingAt: 0)
        }
        guard let d = Data(base64Encoded: st, options: .ignoreUnknownCharacters) else{
            return nil
        }
        return String(data: d, encoding: .utf8)
    }
}
