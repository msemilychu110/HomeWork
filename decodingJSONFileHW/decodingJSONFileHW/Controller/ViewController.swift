//
//  ViewController.swift
//  decodingJSONFileHW
//
//  Created by Field Employee on 9/30/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let netWork = NetworkManager.shared.getInformation() {
            print(netWork)
        }
    }


}

