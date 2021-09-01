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
    @IBOutlet weak var refreshItem: UIBarButtonItem!
    @IBOutlet weak var navigationBackItem: UIBarButtonItem!
    
    public var uID: String = "" {
        didSet {
        }
    }
    
    public var pID: String = "" {
        didSet {
        }
    }
    
    public var idfa: String = "" {
        didSet {
        }
    }
    
    public var gender: String = "" {
        didSet {
        }
    }
    
    public var age: String = "" {
        didSet {
        }
    }
    
    //MARK: - APP LIFE CYCLE
    override func loadView() {
        super.loadView()
        self.navigationItem.title = "포인트 적립소 1"
        initWebKit()
        requestTA() { [weak self] (idfa: String) in
            DispatchQueue.main.async {
                self!.idfa = idfa
                self!.navigationController?.setToolbarHidden(false, animated: true)
                self!.navigationController?.setNavigationBarHidden(false, animated: true)
                self!.checkIDFA(idfa: idfa)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar(color: .white)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.refresh(UIBarButtonItem())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestAPI().getUInfoRequest(idfa: idfa, gender: gender, age: age)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        guard let encodedUid = uID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("encoding Fail")
            return
        }
        
        guard let encodedPid = pID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("encoding Fail")
            return 
        }
        
        let endString = "?pid=\(encodedPid)&uid=\(encodedUid)&os=IOS&platform=APP"
        
        requestAPI().getPointRequest(with: requestAPI().pointBaseURL + endString) { [weak self] (nPoint: Int) in
        }
    }
    
    func initWebKit() {
        webView = WKWebView(frame: CGRect(x: 0, y: 30, width: self.view.bounds.width, height: self.view.bounds.height - 50))

        webView.uiDelegate = self
        webView.navigationDelegate = self
        backwardItem.isEnabled = false
        forwardItem.isEnabled = false
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: {
            (records) -> Void in
            for record in records{
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        })
        
        self.view.addSubview(webView)
    }
    
    func checkIDFA(idfa: String) {
        if idfa != "nil" {
            if #available(iOS 14, *) {
                self.goWeb(uID: self.uID, pID: self.pID, idfa: idfa)
            } else {
                let state = UserDefaults.standard.bool(forKey: "authorizedState")
                if state {
                    self.goWeb(uID: self.uID, pID: self.pID, idfa: idfa)
                } else {
                    let alert = UIAlertController(title: "광고ID 수집 동의", message: "애플의 정책에 따라, 본 서비스를 이용하기 위해서는 iOS 기기의 광고식별자를 수집합니다.", preferredStyle: .alert)
                    let authorizedAction = UIAlertAction(title: "허용", style: .default) { (action) in
                        self.goWeb(uID: self.uID, pID: self.pID, idfa: idfa)
                        UserDefaults.standard.set(true, forKey: "authorizedState")
                    }
                    let deniedAction = UIAlertAction(title: "허용 안 함", style: .destructive) { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(deniedAction)
                    alert.addAction(authorizedAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else if idfa == "nil" {
            
            if #available(iOS 14, *) {
                let alert = UIAlertController(title: "광고ID 수집 동의", message:  "애플의 정책에 따라, 본 서비스를 이용하기 위해서는 iOS 기기의 광고식별자를 수집합니다.", preferredStyle: .alert)
                
                let deniedAction = UIAlertAction(title: "허용 안 함", style: .destructive) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                let allowAction = UIAlertAction(title: "허용", style: .default) { (action) in
                        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(appSettings, options: [:], completionHandler: {_ in
                            })
                        }
                }
                
                alert.addAction(deniedAction)
                alert.addAction(allowAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "광고ID 수집 동의", message:  "애플의 정책에 따라, 본 서비스를 이용하기 위해서는 iOS 기기의 광고식별자를 수집합니다.\n\n ※ 설정 > 개인 정보 보호 > 광고 > 광고 추적 제한 OFF", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "확인", style: .destructive) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
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
    
    @IBAction func popVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        guard let urlString = webView.url?.absoluteString else {
            return
        }
        goRedirectUrl(url: urlString)
    }
    
    
    //MARK: WKWebView Navigation
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        backwardItem.isEnabled = webView.canGoBack
        forwardItem.isEnabled = webView.canGoForward
        
        //MARK: get html page title
//        let javascript = "document.title\n"
//        webView.evaluateJavaScript(javascript) { (result, error) -> Void in
//            if error == nil {
//                self.title = String(describing: result!)
//            }
//        }
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let urlString = webView.url?.absoluteString else {
            return
        }
        let url = URL(string: urlString)
        UIApplication.shared.open(url!, options: [:], completionHandler: { _ in
            webView.reload()
        })
        print("redirect url: \(urlString)")
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {

        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler()
        }))
        

        present(alertController, animated: true, completion: nil)
    }
    
}
