//
//  sampleImage.swift
//  waterfallLayoutFramework
//
//  Created by mac on 2021/05/26.
//

import UIKit

class sampleImage {
    var imageArr = [String]()
    func getSampleImageName() -> [String] {
        for i in 1..<43 {
            let str = String(i) + ".jpg"
            imageArr.append(str)
        }
        return imageArr
    }
    
    var tempArr = [String]()
    
    let youtubeArr = ["https://img.youtube.com/vi/Tp6hnQXRglU/0.jpg"]
    
    let instagramArr = [UIImage]()
    let twitterArr = ["2.jpg"]
    
}
