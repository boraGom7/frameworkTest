//
//  videoViewController.swift
//  waterfallLayoutFramework
//
//  Created by mac on 2021/06/02.
//

import UIKit
import WebKit

public class videoViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    public var videoKey: String = ""
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        getVideo(key: videoKey)

        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        self.webView.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc public func swipeAction(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)

        let waterfallVC = UIStoryboard(name: "waterfallStoryboard", bundle: Bundle(for: waterfallViewController.self)).instantiateViewController(withIdentifier: "waterfallID") as! waterfallViewController
        waterfallVC.tag = "youtube"
        waterfallVC.tempArr = sampleImage().youtubeArr
        waterfallVC.modalPresentationStyle = .fullScreen
        self.present(waterfallVC, animated: true, completion: nil)
    }
    
    func getKey(str: String) {
        self.videoKey = str
        print(videoKey)
    }
    
    public func getVideo(key: String) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=" + "Tp6hnQXRglU") else {
            print("invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
