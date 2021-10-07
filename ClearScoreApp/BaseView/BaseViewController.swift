//
//  BaseViewController.swift
//  ClearScoreApp
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/05.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ================================
    // MARK: System default alert with message & title
    // MARK: ================================

    /// A function to display an AlertView with appropriate title & message text
    func displayAlert(_ title: String, message: String, completion:((_ index: Int) -> Void)?, otherTitles: String? ...) {
        
        if message.trimmedString == "" {
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if !otherTitles.isEmpty {
            // Create multiple buttons on Alertview as per given the list of titles
            for (i, title) in otherTitles.enumerated() {
                alert.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
                    if (completion != nil) {
                        completion!(i)
                    }
                }))
            }
        } else {
            alert.addAction(UIAlertAction(title: "ok_title".localised(), style: .cancel, handler: { (_) in
                if (completion != nil) {
                    completion!(0)
                }
            }))
        }
        
        DispatchQueue.main.async {
            // Placed baseview just to handler orientation situation as per project's need
            self.view.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }

    // A method to display an alert with title
    func displayAlert(_ title: String = Constants.title , message: String) {
        displayAlert(title, message: message, completion: nil)
    }
}
