//
//  FeedTeachViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-11-30.
//

import UIKit

class FeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = feeds[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCellIdentifier) as! FeedTableViewCell
        cell.setAttendFeedCell(obj: feed)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let feed = feeds[indexPath.row]
        print("hello hello")
        if feed.mRequiredAction == "checkout" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "CheckDailyTVController") as! CheckDailyTableViewController
            nextVC.feed = feed
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    @IBOutlet weak var tableViewFeed: UITableView!
    var feeds : [Feed] = []
    fileprivate let feedCellIdentifier = "FeedTeacherCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewFeed.rowHeight = 130
        tableViewFeed.delegate = self
        tableViewFeed.dataSource = self
        toReloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toReloadData()
    }
    
    func toReloadData(){
        Manager.feed.getAllMyFeedParent(completion: { results in
            print("==im here==")
            self.feeds = results
            self.tableViewFeed.reloadData()
        })
    }
}
