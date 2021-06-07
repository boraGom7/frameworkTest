//
//  webViewController.swift
//  webViewFramework
//
//  Created by mac on 2021/05/31.
//

import UIKit
import WebKit

public class webViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, UIGestureRecognizerDelegate {
    @IBOutlet var webView: WKWebView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    public var searchStr: String = ""
    
    public override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: CGRect(x: 0, y: 30, width: self.view.bounds.width, height: self.view.bounds.height))

        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.view = self.webView
    }
    
    public func goWeb(str: String) {
        guard let encodedStr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("encoding Fail")
            return
        }
        guard let url = URL(string: "https://m.search.naver.com/search.naver?sm=mtp_hty.top&where=m&query=" + encodedStr) else {
            print("not valid URL")
            return
        }
        let request = URLRequest(url: url)
        self.webView?.allowsBackForwardNavigationGestures = true
        webView?.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webView?.load(request)
    }
    
    public func getStrData(str: String) {
        self.searchStr = str
        return
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRecognize = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        self.view.addGestureRecognizer(swipeRecognize)
        setStatusBar(color: .white)
        goWeb(str: searchStr)
    }
    
    @objc public func swipeAction(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: true, completion: nil)
    }
    

}

public extension UIViewController {
    func setStatusBar(color: UIColor) {
        let tag = 12321
        if let taggedView = self.view.viewWithTag(tag){
            taggedView.removeFromSuperview()
        }
        let overView = UIView()
        overView.frame = UIApplication.shared.statusBarFrame
        overView.backgroundColor = color
        overView.alpha = 0.9
        overView.tag = tag
        self.view.addSubview(overView)
    }
}
