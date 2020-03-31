//
//  PodcastModel.swift
//  Podcasts and News
//
//  Created by Ethan Stebbins on 24/3/20.
//  Copyright © 2020 Ethan Stebbins. All rights reserved.
//

import Foundation

class PodcastModel: NSObject {
    
    var name: String?
    var title: String?
    var uploaded_on: String?
    var user: String?
    var thumbnail: String?
    
    override init() {
        
    }
    
    init(name: String, title: String, uploaded_on: String, user: String, thumbnail: String) {
        self.name = name
        self.title = title
        self.uploaded_on = uploaded_on
        self.user = user
        self.thumbnail = thumbnail
    }
    
    override var description: String {
        return "Podcasturl: \(name), Title: \(title), Uploaded On: \(uploaded_on), Uploaded By: \(user), Thumbnail: \(thumbnail)"
    }
}
