//
//  NewsLoader.swift
//  Podcasts and News
//
//  Created by Ethan Stebbins on 25/3/20.
//  Copyright © 2020 Ethan Stebbins. All rights reserved.
//

import UIKit

class NewsLoader: UIViewController {
    var news:String = ""
    
    
    @IBOutlet var NewsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        NewsView?.text = news
    }
}
