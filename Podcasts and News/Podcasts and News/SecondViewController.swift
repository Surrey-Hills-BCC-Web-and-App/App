//
//  SecondViewController.swift
//  Podcasts and News
//
//  Created by Ethan Stebbins on 20/3/20.
//  Copyright © 2020 Ethan Stebbins. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var Thumbnail: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
}


class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelNProtocal, UITextFieldDelegate {
    @IBOutlet weak var listTableView: UITableView!
    var feedItems: NSArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModelN = HomeModelN()
        homeModelN.delegate = self
        homeModelN.downloadItems()
    }
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.listTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NewsTableViewCell"
        let cell: NewsViewCell = self.listTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! NewsViewCell
        let item: WhatsOnModel = feedItems[indexPath.row] as! WhatsOnModel
        let imageUrlString = item.thumbnail
        let imageUrl = URL(string: imageUrlString!)
        let imageData = try! Data(contentsOf: imageUrl!)
        
        cell.newsLabel?.text = item.title
        cell.userLabel?.text = item.user
        cell.timeLabel?.text = item.uploaded_on
        cell.Thumbnail?.image = UIImage(data: imageData)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "showView", sender: self)
        self.listTableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showView" {
            if let indexPath = self.listTableView.indexPathForSelectedRow {
                let item: WhatsOnModel = feedItems[indexPath.row] as! WhatsOnModel
                let url = URL(string: item.name!)
                let imageUrlString = item.thumbnail
                let imageUrl = URL(string: imageUrlString!)
                do {
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: item.title, style: .plain, target: nil, action: nil)
                    let vc = segue.destination as! NewsLoader
                    let data = try String.init(contentsOf: url!)
                    vc.news = data as String
                    let imageData = try! Data(contentsOf: imageUrl!)
                    vc.imageData = UIImage(data: imageData)
                }
                catch let error as NSError {
                print("An error took place: \(error)")
                }
            }
        }
    }


}

