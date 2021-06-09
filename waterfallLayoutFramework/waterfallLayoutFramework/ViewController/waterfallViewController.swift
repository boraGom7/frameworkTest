//
//  waterfallViewController.swift
//  waterfallLayoutFramework
//
//  Created by mac on 2021/05/26.
//

import UIKit

public class waterfallViewController: UIViewController {
    
    @IBOutlet weak var waterfallCollectionView: UICollectionView!
    let paging = pagingViewModel()
    
    var tempArr = sampleImage().getSampleImageName() {
        didSet {
            print("tempArr \(tempArr)")
        }
    }
    var tag: String = "image" {
        didSet {
        }
    }
    
    var selectedIndex: IndexPath?
    
    @IBOutlet weak var AllButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        AllButton.layer.cornerRadius = 23
        youtubeButton.layer.cornerRadius = 20
        instagramButton.layer.cornerRadius = 20
        twitterButton.layer.cornerRadius = 20
        
        waterfallCollectionView.allowsSelection = true
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetching()
        
    }
    
    public init() {
        super.init(nibName: "waterfallViewController", bundle: Bundle(for: waterfallViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makeWaterfallLayout() {
        DispatchQueue.main.async {
            self.waterfallCollectionView.reloadData()
            let pinterestLayout = PinterestLayout()
            pinterestLayout.delegate = self
            self.waterfallCollectionView.dataSource = self
            self.waterfallCollectionView.delegate = self
            self.waterfallCollectionView?.collectionViewLayout = pinterestLayout
        }
    }
    
    func fetching() {
        if self.paging.imageIndex == 0 {
            paging.getImage(imageArr: tempArr, tag: tag)
            makeWaterfallLayout()
            
        } else if paging.fetchingMore == true && paging.isLoading == true {
            paging.getImage(imageArr: tempArr, tag: tag)
            print("fetchingMore")
            
            makeWaterfallLayout()
            paging.fetchingMore = false
            paging.isLoading = false
        }
    }
    
    @IBAction func allClick(_ sender: Any) {
        var cache = PinterestLayout.layoutAttributesForItem(PinterestLayout())
        print(cache)
        //cache = UICollectionViewLayoutAttributes()
        self.tempArr = sampleImage().getSampleImageName()
        self.tag = "image"
        paging.imageDatas = [UIImage]()
        paging.imageIndex = 0
        fetching()
    }
    
    @IBAction func youtubeClick(_ sender: Any) {
        self.tempArr = sampleImage().youtubeArr
        self.tag = "youtube"
        paging.imageDatas = [UIImage]()
        paging.imageIndex = 0
        fetching()
    }
    
    @IBAction func twitterClick(_ sender: Any) {
        self.tempArr = sampleImage().twitterArr
        self.tag = "twitter"
        paging.imageDatas = [UIImage]()
        paging.imageIndex = 0
        fetching()
    }
    
}

public class waterfallCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
}

extension waterfallViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paging.imageDatas.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = waterfallCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? waterfallCell else {
            fatalError()
        }
        let image = paging.imageDatas[indexPath.row]
        cell.cellImage.image = image
        cell.layer.cornerRadius = 12
        
        if selectedIndex == indexPath {

        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath || selectedIndex == nil {
            selectedIndex = indexPath
            
            if self.tag == "youtube" {
                videoViewController().getKey(str: "cat")
                let webVC = UIStoryboard(name: "waterfallStoryboard", bundle: Bundle(for: videoViewController.self)).instantiateViewController(withIdentifier: "webID") as! videoViewController
                webVC.modalPresentationStyle = .fullScreen
                self.present(webVC, animated: true, completion: nil)
            }
            
            if self.tag == "twitter" {
                let webVC = UIStoryboard(name: "waterfallStoryboard", bundle: Bundle(for: snsCollectionViewController.self)).instantiateViewController(withIdentifier: "snsID") as! snsCollectionViewController
                webVC.modalPresentationStyle = .fullScreen
                self.present(webVC, animated: true, completion: nil)
            }
        }
    }
    
}

extension waterfallViewController: PinterestLayoutDelegate {
    public func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = paging.imageDatas[indexPath.row]
        let ratio = image.size.width / image.size.height
        let cellWidth: CGFloat = (view.bounds.width - 20) / 2
        return cellWidth / ratio
    }
}

extension waterfallViewController: UIScrollViewDelegate {
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            var currentOffset =  self.waterfallCollectionView.contentSize.height
            print("currentOffset \(currentOffset)")
            //self.waterfallCollectionView.setContentOffset(currentOffset, animated: false)
            print("scroll End")
            self.paging.isLoading = true
            self.paging.fetchingMore = true
            fetching()
        }
    }
}
