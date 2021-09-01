//
//  callWebVC.swift
//  webViewFramework
//
//  Created by mac on 2021/06/15.
//

import UIKit

public func callWebVC(uID: String, pID: String, gender: String, age: String) {
    
    if #available(iOS 13.0, *) {
        let storyBoard = UIStoryboard(name: "webStoryboard", bundle: Bundle(for: webViewController.self))
        guard let vc = storyBoard.instantiateViewController(identifier: "webID") as? webViewController else { return }
        vc.getStrData(uID: uID, pID: pID, age: age, gender: gender)
        
        if let topVC = UIApplication.topViewController() {
            topVC.navigationController?.pushViewController(vc, animated: true)
            
            topVC.navigationController?.navigationBar.tintColor = .black
            let backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: webViewController.self, action: nil)
            topVC.navigationItem.backBarButtonItem = backBarButtonItem
        }
    } else {
        let storyBoard = UIStoryboard(name: "webStoryboard", bundle: Bundle(for: webViewController.self))
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "webID") as? webViewController else { return }
        vc.getStrData(uID: uID, pID: pID, age: age, gender: gender)
        
        if let topVC = UIApplication.topViewControllerUnder11() {
            topVC.navigationController?.pushViewController(vc, animated: true)
            
            topVC.navigationController?.navigationBar.tintColor = .black
            let backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: webViewController.self, action: nil)
            topVC.navigationItem.backBarButtonItem = backBarButtonItem
        }
    }
}

extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected) } }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    
    class func topViewControllerUnder11(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewControllerUnder11(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewControllerUnder11(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewControllerUnder11(base: presented)
        }
        return base
    }
}
