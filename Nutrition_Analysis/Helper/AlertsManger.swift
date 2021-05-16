//
//  AlertsManger.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/5/21.
//

import UIKit

class AlertsManager {
    
    static let topVC = UIApplication.topViewController()
    //=================
    // MARK: Show Alert
    //=================
    static func showAlert(
        withTitle title: String?,
        message: String?,
        viewController: UIViewController?,
        showingCancelButton: Bool = false,
        cancelHandler: ((UIAlertAction) -> Void)? = nil,
        actionTitle: String = "OK",
        actionStyle: UIAlertAction.Style = .default,
        actionHandler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: actionTitle, style: actionStyle, handler: actionHandler)
        alertController.addAction(okAction)
        
        if showingCancelButton {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
            alertController.addAction(cancelAction)
        }
        
        if let presentingVC = viewController {
            presentingVC.present(alertController, animated: true, completion: nil)
        } else {
            topVC?.present(alertController, animated: true, completion: nil)
        }
    } // showAlert
}


extension UIApplication {
    
    //=========================
    //MARK: Top View Controller
    //=========================
    
    /// Get an instance of the top view controller which appeares on screen.
    ///
    /// - Parameter baseViewController: parent class to start with it and make recursion operation to get top view controller
    /// - Returns: an instance of the top view controller
    
    class func topViewController(baseViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        guard let navigationController = baseViewController as? UINavigationController else {
            if let tabBarViewController = baseViewController as? UITabBarController {
                
                let moreNavigationController = tabBarViewController.moreNavigationController
                if let mostTopViewController = moreNavigationController.topViewController, mostTopViewController.view.window != nil {
                    return topViewController(baseViewController:mostTopViewController)
                } else if let selectedViewController = tabBarViewController.selectedViewController {
                    return topViewController(baseViewController: selectedViewController)
                }
            }
            
            guard let splitViewController = baseViewController as? UISplitViewController, splitViewController.viewControllers.count == 1 else {
                guard let presentedViewController = baseViewController?.presentedViewController else {
                    return baseViewController
                }
                return topViewController(baseViewController: presentedViewController)
            }
            return topViewController(baseViewController: splitViewController.viewControllers[0])
        }
        return topViewController(baseViewController: navigationController.visibleViewController)
        
    } // topViewController

}
