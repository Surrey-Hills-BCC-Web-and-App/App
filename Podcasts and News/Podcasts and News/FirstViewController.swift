//
//  FirstViewController.swift
//  Podcasts and News
//
//  Created by Ethan Stebbins on 20/3/20.
//  Copyright © 2020 Ethan Stebbins. All rights reserved.
//

import UIKit
import WebKit

class FirstViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let webaddress = "http://127.0.0.1/WVPodcasts.php"
        if let url = URL(string: webaddress) {
            let urlRequest = URLRequest(url: url)
            self.webView.load(urlRequest)
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}
