//
//  ViewController.swift
//  Meteors
//
//  Created by Ulaş Sancak on 29.09.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let api = MeteorAPI()
        api.start { response in
            print(response)
        }
    }


}

