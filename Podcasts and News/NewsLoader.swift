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
    var imageData: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var NewsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        NewsView?.text = news
        if let image = imageData {
             imageView.image = image
        }
    }
}
