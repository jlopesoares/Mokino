//
//  CollectionLostViewController.swift
//  Mokino
//
//  Created by João Pedro on 22/08/2022.
//

import UIKit

class CollectionLostViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.text = "Connection.Lost".localized
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
