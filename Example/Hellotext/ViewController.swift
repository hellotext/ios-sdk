//
//  ViewController.swift
//  Hellotext
//
//  Created by Breno Morais on 11/19/2024.
//  Copyright (c) 2024 Breno Morais. All rights reserved.
//

import UIKit
import Hellotext

class ViewController: UIViewController {
    let hellotext = Hellotext.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        let actionName = "manual-event"
        let params: [String: Any] = [
            "name": "manual-event-config"
        ]

        hellotext.track(action: actionName, appParameters: params)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

