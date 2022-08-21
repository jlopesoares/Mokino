//
//  UIViewController+Extensions.swift
//  Mokino
//
//  Created by João Pedro on 21/08/2022.
//

import UIKit

extension UIViewController {
    
    func presentConnectionLostViewController() {
     
        let connectionLostViewController = UIStoryboard.main.connectionLostViewController
        connectionLostViewController?.modalPresentationStyle = .fullScreen
        present(connectionLostViewController!, animated: true)
    }
}
