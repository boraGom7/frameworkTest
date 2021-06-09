//
//  pagingViewModel.swift
//  waterfallLayoutFramework
//
//  Created by mac on 2021/05/26.
//

import UIKit

class pagingViewModel {
    
    var fetchingMore = false {
        didSet {
            print("fetchingMore didSet \(fetchingMore)")
        }
    }
    var newItem: Array = [String]()
    var imageDatas: Array = [UIImage]() {
        didSet {
        }
    }
    var imageIndex = 0
    var isLoading: Bool = false {
        didSet {
            print("isLoading didSet \(isLoading)")
        }
    }
    
    func getImage(imageArr: [String], tag: String) {
        for _ in 0..<20 {
            print(imageIndex)
            if self.imageIndex <= imageArr.count-1  {
                if tag == "image" || tag == "twitter" {
                    let imageName = imageArr[self.imageIndex]
                    guard let image = UIImage(named: imageName) else {
                        return
                    }
                    imageDatas.append(image)
                }
                else if tag == "youtube" {
                    let urlString = imageArr[self.imageIndex]
                    guard let imageUrl = URL(string: urlString) else { return }
                    guard let data = try? Data(contentsOf: imageUrl) else { return }
                    guard let image = UIImage(data: data) else { return }
                    imageDatas.append(image)
                }
                self.imageIndex += 1
            } else {
                break
            }
        }
        print("imageDatas \(imageDatas)")
    }
}
