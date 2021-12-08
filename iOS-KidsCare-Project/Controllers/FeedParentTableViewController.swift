//
//  FeedParentTableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-11-30.
//

import UIKit

class FeedParentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = feeds[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: feedCellIdentifier) as! FeedParentTableViewCell
        cell.setAttendFeedCell(obj: feed)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let feed = feeds[indexPath.row]
        if feed.mRequiredAction == "ACEPTAR" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "AcceptKidTVController") as! AcceptKidTableViewController
            nextVC.feed = feed
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    @IBOutlet weak var tableViewFeed: UITableView!
    var feeds : [Feed] = []
    private let attendViewControllerSegueIdentifier = "toAttendanceKid"
    fileprivate let feedCellIdentifier = "FeedParentCell"
    
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
        print("reload data")
        Manager.feed.getAllMyFeed(completion: { results in
            self.feeds = results
            self.tableViewFeed.reloadData()
        })
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier! {
//        case attendViewControllerSegueIdentifier:
//            if let vc = segue.destination as? DailyTableViewController {
//
//                let selectedIndexPath = self.tableViewFeed.indexPathForSelectedRow!
//                let selectedToddler = self.toddlers[selectedIndexPath.row]
//
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyyMMdd"
//                let dateString = dateFormatter.string(from: Date())
//
//                vc.currentIdToddler = selectedToddler.mUid
//                vc.currentIdActivity = selectedToddler.mUid! + dateString
//                vc.nameToddler =  selectedToddler.mName
//            }
//
//        default:
//                break
//            }
//    }

}
