//
//  callWebVC.swift
//  webViewFramework
//
//  Created by mac on 2021/06/15.
//

import UIKit

public func callWebVC() {
    
//    let storyboardVC = UIStoryboard(name: "webStoryboard", bundle: Bundle(for: webViewController.self)).instantiateViewController(withIdentifier: "webID") as! webViewController
//    storyboardVC.modalPresentationStyle = .fullScreen
//    storyboardVC.getStrData(str: "")
//    if let topVC = UIApplication.topViewController() {
//        topVC.present(storyboardVC, animated: true, completion: nil)
//    }
    
    let storyBoard = UIStoryboard(name: "webStoryboard", bundle: Bundle(for: webViewController.self))
    guard let vc = storyBoard.instantiateViewController(identifier: "webID") as? webViewController else { return }
    //webViewController().getStrData(str: "1")
    if let topVC = UIApplication.topViewController() {
        topVC.navigationController?.pushViewController(vc, animated: true)

        topVC.navigationController?.navigationBar.tintColor = .black
        let backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: webViewController.self, action: nil)
        topVC.navigationItem.backBarButtonItem = backBarButtonItem
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
}
