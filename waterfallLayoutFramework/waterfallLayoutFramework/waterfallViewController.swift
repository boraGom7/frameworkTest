//
//  waterfallViewController.swift
//  waterfallLayoutFramework
//
//  Created by mac on 2021/05/26.
//

import UIKit

public class waterfallViewController: UIViewController {
    @IBOutlet weak var waterfallCollectionView: UICollectionView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinterestLayout = PinterestLayout()
        pinterestLayout.delegate = self
        waterfallCollectionView?.collectionViewLayout = pinterestLayout
        // Do any additional setup after loading the view.
    }
    
    public override func viewDidAppear(_ animated: Bool) {
       // paging()
    }
    
    public init() {
        super.init(nibName: "waterfallViewController", bundle: Bundle(for: waterfallViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class waterfallCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    
}

extension waterfallViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleImage().imageArr.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = waterfallCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? waterfallCell else {
            fatalError()
        }
        let imageName = sampleImage().imageArr[indexPath.row]
        cell.cellImage.image = UIImage(named: imageName)
        cell.layer.cornerRadius = 12
        return cell
    }
    
}

extension waterfallViewController: PinterestLayoutDelegate {
    public func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let imageName = sampleImage().imageArr[indexPath.item]
        guard let image = UIImage(named: imageName) else {
            return CGFloat()
        }
        let ratio = image.size.width / image.size.height
        let cellWidth: CGFloat = (view.bounds.width - 32) / 2
        
        return cellWidth / ratio
    }
}
