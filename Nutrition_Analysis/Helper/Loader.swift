//
//  Loader.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/15/21.
//

import Foundation
import UIKit


class Loader {
    
    static var cachedBtnTitle = ""
    static func startIndicator(view: UIView, loaderColor: UIColor = UIColor.orange, withOverlay: Bool = false) {
        if withOverlay {
            let overLayView = UIView(frame: view.frame)
            overLayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            overLayView.tag = 8709
            
            let activityIndicator = UIActivityIndicatorView(style: .white)
            activityIndicator.color = loaderColor
            activityIndicator.center = view.center
            activityIndicator.tag = 4994
            overLayView.addSubview(activityIndicator)
            view.addSubview(overLayView)
            activityIndicator.startAnimating()
        } else {
            if let btnView = view as? UIButton {
                cachedBtnTitle = btnView.titleLabel?.text ?? ""
                btnView.setTitle("", for: .normal)
            }
            let activityIndicator = UIActivityIndicatorView(style: .white)
            activityIndicator.color = loaderColor
            activityIndicator.center = view.center
            activityIndicator.tag = 4994
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }
    
    static func removeLoader(view: UIView, withOverlay: Bool = false) {
        if withOverlay {
            if let overlayView = view.viewWithTag(8709) {
                overlayView.removeFromSuperview()
            }
        } else {
            if let activityIndicator = view.viewWithTag(4994) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                if let btnView = view as? UIButton {
                    btnView.setTitle(cachedBtnTitle, for: .normal)
                }
            }
        }
    }
}
