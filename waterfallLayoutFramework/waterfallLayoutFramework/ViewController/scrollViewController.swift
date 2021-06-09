//
//  tableViewController.swift
//  waterfallLayoutFramework
//
//  Created by mac on 2021/06/02.
//

import UIKit
import AVFoundation
import AVKit

public class scrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var xPos = CGFloat()
    let imageView = UIImageView()
    var isPage: Bool = false
    var pageNum: Int? = 0
    var player = AVPlayer()
    
    
    var images: [String] = ["2.jpg", "6.jpg", "9.jpg", "19.jpg", "end", "start"]
//    var imageViews = [UIImageView]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        addContentScrollView(i: 0)

        // Do any additional setup after loading the view.
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setPageControl()
        //addContentScrollView()
//        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player, queue: nil) { (_) in
//            self.player.seek(to: CMTime.zero)
//            print("video end")
//            self.player.play()
//
//        }
    }
    
    private func addImage(i: Int) -> UIImageView {
        
            let imageView = UIImageView()
            var xPos = scrollView.bounds.width * CGFloat(i)
            
            guard let image = UIImage(named: images[i]) else {
                return UIImageView()
            }
            let ratio = image.size.height / image.size.width
            let imageHeight: CGFloat = scrollView.bounds.height
            let imageWidth = imageHeight / ratio
            imageView.image = image
            
            let space: CGFloat = (scrollView.bounds.width - imageWidth - 24) / 2
            xPos += space

            imageView.frame = CGRect(x: xPos, y: 0, width: imageWidth, height: imageHeight)
//        scrollView.addSubview(imageView)
//        scrollView.contentSize.width = scrollView.bounds.width * CGFloat(i + 1)
        return imageView

        
    }
    
    private func playVideo(i: Int) -> AVPlayerLayer {
        var xPos = scrollView.bounds.width * CGFloat(i)
        
        guard let path = Bundle.main.path(forResource: images[i], ofType: "mp4") else {
            return AVPlayerLayer()
        }
        let videoURL = URL(fileURLWithPath: path)

        self.player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        player.play()
//        scrollView.layer.addSublayer(playerLayer)
//        scrollView.contentSize.width = scrollView.bounds.width * CGFloat(i + 1)
        if pageNum == 3 {
            player.play()
            print("play")
            player.seek(to: CMTime.zero)
        }
        return playerLayer
    }

    func addContentScrollView(i: Int) {
        for i in 0..<images.count {
            self.xPos = scrollView.bounds.width * CGFloat(i)
            
            if images[i].contains("jpg") {
                let image = addImage(i: i)
                scrollView.addSubview(image)
                scrollView.addSubview(imageView)
                scrollView.contentSize.width = scrollView.bounds.width * CGFloat(i + 1)
            } else {
                
                print("video")
//                guard let path = Bundle.main.path(forResource: images[i], ofType: "mp4") else {
//                    return
//                }
//
//                let videoURL = URL(fileURLWithPath: path)
//                print(videoURL)
//                let player = AVPlayer(url: videoURL)

                //                let playerController = AVPlayerViewController()
                //                playerController.player = player
                //                playerController.view.frame = scrollView.frame
                //
                //                playerController.player?.play()
                //                scrollView.addSubview(playerController.view)
//
//                let playerLayer = AVPlayerLayer(player: player)
//                playerLayer.frame = CGRect(x: self.xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
                let playerLayer = playVideo(i: i)
                
                scrollView.layer.addSublayer(playerLayer)
                scrollView.contentSize.width = scrollView.bounds.width * CGFloat(i + 1)

                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player, queue: nil) { (_) in
                    self.player.seek(to: CMTime.zero)
                    print("video end")
//                    player.play()

                }
                
            }
        }
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
        
    }
    
    private func getPage(currentPage:Int) {
        self.isPage = true
        self.pageNum = currentPage
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
        getPage(currentPage: Int(round(value)))
        self.pageNum = Int(round(value))
        addContentScrollView(i: Int(round(value)))
        let image = addImage(i: pageNum!)
        playVideo(i: 4)
        //player.play()
    }

}
