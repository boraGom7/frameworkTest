//
//  snsCollectionViewController.swift
//  waterfallLayoutFramework
//
//  Created by mac on 2021/06/04.
//

import UIKit
import AVFoundation
import AVKit

public class snsCollectionViewController: UIViewController {
    @IBOutlet weak var snsCollectionView: UICollectionView!
    var looper: AVPlayerLooper?
    
    var xPos: CGFloat = 0
    var currentIndex = 0
    
    var images: [String] = ["2.jpg", "6.jpg", "9.jpg", "19.jpg", "end"]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        snsCollectionView.delegate = self
        snsCollectionView.dataSource = self
        snsCollectionView.isPagingEnabled = true

        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc public func swipeAction(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)

        let waterfallVC = UIStoryboard(name: "waterfallStoryboard", bundle: Bundle(for: waterfallViewController.self)).instantiateViewController(withIdentifier: "waterfallID") as! waterfallViewController
        waterfallVC.tag = "twitter"
        waterfallVC.tempArr = sampleImage().twitterArr
        waterfallVC.modalPresentationStyle = .fullScreen
        self.present(waterfallVC, animated: true, completion: nil)
    }
    
    private func addImage(i: Int) -> UIImage {
        guard let image = UIImage(named: images[i]) else {
            return UIImage()
        }
        
        return image
    }
    
    private func getVideo(i: Int) -> AVPlayer {
        guard let path = Bundle.main.path(forResource: images[i], ofType: "mp4") else {
            return AVPlayer()
        }
        let videoURL = URL(fileURLWithPath: path)
        print(videoURL)
        
        let player = AVPlayer(url: videoURL)
        
        return player
    }

}

class snsCell: UICollectionViewCell {
    @IBOutlet weak var snsImage: UIImageView!
}

extension snsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = snsCollectionView.dequeueReusableCell(withReuseIdentifier: "snsCell", for: indexPath) as! snsCell

            if images[indexPath.row].contains("jpg") {
                cell.snsImage.layer.sublayers = nil
                let image = addImage(i: indexPath.row)
                cell.snsImage.image = image
            } else {
                cell.snsImage.image = nil
                print("contains mp4")
                
                guard let path = Bundle.main.path(forResource: images[indexPath.row], ofType: "mp4") else {
                    print("invalid path")
                    return UICollectionViewCell()
                }
                let videoURL = URL(fileURLWithPath: path)
                let item = AVPlayerItem(url: videoURL)
                
                let queuePlayer = AVQueuePlayer(playerItem: item)
                self.looper = AVPlayerLooper(player: queuePlayer, templateItem: item)
                let playerLayer = AVPlayerLayer(player: queuePlayer)
                playerLayer.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
                cell.snsImage.layer.addSublayer(playerLayer)
                queuePlayer.play()
            }
        
        return cell
    }
    
}

extension snsCollectionViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetX = scrollView.contentOffset.x
        self.xPos = self.view.bounds.width * CGFloat(currentIndex)
        
        if offsetX <= self.view.bounds.width * CGFloat(images.count) {
            if self.xPos < offsetX {
                currentIndex += 1
                print(currentIndex)
                DispatchQueue.main.async {
                    self.snsCollectionView.reloadData()
                }
                
            } else if self.xPos > offsetX {
                currentIndex -= 1
                DispatchQueue.main.async {
                    self.snsCollectionView.reloadData()
                }
            }
        }
    }
}

extension snsCollectionViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if images[indexPath.row].contains("jpg") {
            let image = addImage(i: indexPath.row)
            let ratio = image.size.height / image.size.width
            let imageHeight: CGFloat = 250
            let imageWidth = imageHeight / ratio
            
            return CGSize(width: self.view.bounds.width, height: imageHeight)
        }
        
        return CGSize(width: self.view.bounds.width, height: 250)
    }
}
