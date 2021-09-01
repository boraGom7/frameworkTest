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
        
        if #available(iOS 13.0, *) {
            overView.frame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect()
            overView.backgroundColor = color
            overView.alpha = 0.9
            overView.tag = tag
            self.view.addSubview(overView)
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.white
            statusBar?.alpha = 0.9
        }
        
    }
    
}

