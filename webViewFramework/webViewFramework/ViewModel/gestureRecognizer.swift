//
//  gestureRecognizer.swift
//  webViewFramework
//
//  Created by mac on 2021/06/16.
//

import UIKit

extension webViewController: UIGestureRecognizerDelegate {
    
    @objc func panAction(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: webView)
        
        if velocity.y > 0 {
            //gesture: down
            self.navigationController?.setToolbarHidden(false, animated: true)
        } else {
            self.navigationController?.setToolbarHidden(true, animated: true)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
