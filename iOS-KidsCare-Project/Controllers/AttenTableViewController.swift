//
//  AttenTableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-05.
//

import UIKit

class AttenTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(toddlers.count)
        return toddlers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toddler = toddlers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: toddlerCellIdentifier) as! AttendTableViewCell
        cell.setAttendToddlerCell(obj: toddler)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBOutlet weak var tableViewKids: UITableView!
    var toddlers : [Toddler] = []
    private let attendViewControllerSegueIdentifier = "toAttendanceKid"
    fileprivate let toddlerCellIdentifier = "AttendanceCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "dd/MM/yyyy"
        //let dateString = dateFormatter.string(from: Date())
        
        //title = dateString
        tableViewKids.rowHeight = 75
        tableViewKids.delegate = self
        tableViewKids.dataSource = self
        toReloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toReloadData()
    }
    
    func toReloadData(){
        Manager.user.getToddlersAttendance(completion: { results in
            self.toddlers = results
            self.tableViewKids.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case attendViewControllerSegueIdentifier:
            if let vc = segue.destination as? DailyTableViewController {
                
                let selectedIndexPath = self.tableViewKids.indexPathForSelectedRow!
                let selectedToddler = self.toddlers[selectedIndexPath.row]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                let dateString = dateFormatter.string(from: Date())
                
                vc.toddler = selectedToddler
                vc.currentIdToddler = selectedToddler.mUid
                vc.currentIdActivity = selectedToddler.mUid! + dateString
                vc.nameToddler =  selectedToddler.mName
            }
            
        default:
                break
            }
    }

}
