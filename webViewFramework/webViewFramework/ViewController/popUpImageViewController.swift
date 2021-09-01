//
//  popUpImageViewController.swift
//  webViewFramework
//
//  Created by mac on 2021/07/13.
//

import UIKit

class popUpImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "settingGuide.jpeg")
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 120)
        
        self.view.addSubview(imageView)
        
        self.preferredContentSize = CGSize(width: 200, height: 120)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
