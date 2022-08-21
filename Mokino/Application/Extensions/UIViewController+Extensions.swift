//
//  UIViewController+Extensions.swift
//  Mokino
//
//  Created by João Pedro on 21/08/2022.
//

import UIKit

extension UIViewController {
    
    func presentConnectionLostViewController() {
     
        guard let connectionLostVC = UIStoryboard.main.connectionLostViewController else {
            return
        }

        connectionLostVC.modalPresentationStyle = .fullScreen
        present(connectionLostVC, animated: true)
    }
}
