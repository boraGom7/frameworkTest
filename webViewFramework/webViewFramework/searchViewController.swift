//
//  searchViewController.swift
//  webViewFramework
//
//  Created by mac on 2021/05/31.
//

import UIKit

public class searchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        searchButton.layer.cornerRadius = 5
    }
    
    @IBAction func clickGo(_ sender: Any) {
        guard let webVC = storyboard?.instantiateViewController(identifier: "webID") as? webViewController else {
            return
        }
        webVC.searchStr = self.searchBar.text ?? ""
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true, completion: nil)
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
