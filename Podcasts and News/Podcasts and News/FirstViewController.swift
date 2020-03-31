//
//  FirstViewController.swift
//  Podcasts and News
//
//  Created by Ethan Stebbins on 20/3/20.
//  Copyright © 2020 Ethan Stebbins. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PodcastViewCell: UITableViewCell {
    
    
    @IBOutlet weak var podcastLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var Thumbnail: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelPProtocal {
    var playerViewController=AVPlayerViewController()
    var playerView = AVPlayer()
    var feedItems: NSArray = NSArray()
    var selectedPodcast : PodcastModel = PodcastModel()
    @IBOutlet var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModelP = HomeModelP()
        homeModelP.delegate = self
        homeModelP.downloadItems()
    }
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.listTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PodcastTableViewCell"
        let cell: PodcastViewCell = self.listTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PodcastViewCell
        let item: PodcastModel = feedItems[indexPath.row] as! PodcastModel
        let imageUrlString = item.thumbnail
        let imageUrl = URL(string: imageUrlString!)
        let imageData = try! Data(contentsOf: imageUrl!)
        
        cell.podcastLabel?.text = item.title
        cell.userLabel?.text = item.user
        cell.timeLabel?.text = item.uploaded_on
        cell.Thumbnail?.image = UIImage(data: imageData)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showVideoPlayer", sender: self)
        self.listTableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVideoPlayer" {
            if let indexPath = self.listTableView.indexPathForSelectedRow {
                let video: PodcastModel = feedItems[indexPath.row] as! PodcastModel
                let destination = segue.destination as! AVPlayerViewController
                let url = URL(string: video.name!)
                destination.player = AVPlayer(url: url!)
                destination.player?.play()
            }
        }
    }
}
var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }



