//
//  setStatusBar.swift
//  webViewFramework
//
//  Created by mac on 2021/06/16.
//

import UIKit

extension UIViewController {
    func setStatusBar(color: UIColor) {
        let tag = 12321
        if let taggedView = self.view.viewWithTag(tag){
            taggedView.removeFromSuperview()
        }
        let overView = UIView()
        overView.frame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect()
        overView.backgroundColor = color
        overView.alpha = 0.9
        overView.tag = tag
        self.view.addSubview(overView)
    }
}

