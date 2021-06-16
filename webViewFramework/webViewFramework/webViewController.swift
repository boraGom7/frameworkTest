//
//  webViewController.swift
//  webViewFramework
//
//  Created by mac on 2021/05/31.
//

import UIKit
import WebKit

class webViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    //MARK: @IBOULET
    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var backwardItem: UIBarButtonItem!
    @IBOutlet weak var forwardItem: UIBarButtonItem!
    
    var lastOffsetY: CGFloat = 0
    public var searchStr: String = ""
    
    //MARK: APP LIFE CYCLE: loadView
    public override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: CGRect(x: 0, y: 30, width: self.view.bounds.width, height: self.view.bounds.height))

        webView.uiDelegate = self
        webView.navigationDelegate = self
        backwardItem.isEnabled = false
        forwardItem.isEnabled = false
        
        self.view = self.webView
    }
    
    //MARK: APP LIFE CYCLE: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_ :)))
        panRecognizer.delegate = self
        self.view.addGestureRecognizer(panRecognizer)
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        setStatusBar(color: .white)
        goWeb(str: searchStr)
    }
    
    //MARK: APP LIFE CYCLE: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    //MARK: @IBACTION
    @IBAction func goBack(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForward(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    //MARK: WKWebView Navigation
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backwardItem.isEnabled = webView.canGoBack
        forwardItem.isEnabled = webView.canGoForward
        
        //MARK: get html page title
        let javascript = "document.title\n"
        webView.evaluateJavaScript(javascript) { (result, error) -> Void in
            if error == nil {
                self.title = String(describing: result!)
                print(self.title!)
            }
        }
    }
    
}
