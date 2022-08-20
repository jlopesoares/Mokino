//
//  UIImageView+Extensions.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(url: URL?) {
        
        guard let url = url else {
            return
        }
        
        kf.setImage(with: url,
                    options: [.cacheOriginalImage,
                              .transition(.fade(0.1)),
                              .forceTransition])
    }
}
