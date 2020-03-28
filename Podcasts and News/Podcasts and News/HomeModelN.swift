//
//  HomeModel.swift
//  Podcasts and News
//
//  Created by Ethan Stebbins on 24/3/20.
//  Copyright © 2020 Ethan Stebbins. All rights reserved.
//

import Foundation

protocol HomeModelNProtocal: class {
    func itemsDownloaded(items: NSArray)
}

class HomeModelN: NSObject, URLSessionDataDelegate {
    weak var delegate: HomeModelNProtocal?
    var data = Data()
    let urlPath: String = "http://10.0.0.86/AppService/ServiceN.php"
    
    func downloadItems() {
        
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed to download data")
            }else{
                print("Data Download")
                self.parseJSON(data!)
            }
        }
        task.resume()
        
        }
    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
    
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let news = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let new = WhatsOnModel()
            let name1 = jsonElement["name"] as! String
            if let name = "http://10.0.0.86/News/\(name1)" as? String,
                let title = jsonElement["title"] as? String,
                let uploaded_on = jsonElement["uploaded_on"] as? String,
                let user = jsonElement["user"] as? String
            {
                
                
                new.name = name
                new.title = title
                new.uploaded_on = uploaded_on
                new.user = user
            }
            
            news.add(new)
        }
        DispatchQueue.main.async (execute: { () -> Void in self.delegate?.itemsDownloaded(items: news)})
    }
}
