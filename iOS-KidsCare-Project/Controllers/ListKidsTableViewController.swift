//
//  ListKidsTableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-04.
//

import UIKit

class ListKidsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(toddlers.count)
        return toddlers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toddler = toddlers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: toddlerCellIdentifier) as! ToddlerTableViewCell
        cell.setToddlerCell(obj: toddler)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBOutlet weak var tableViewKids: UITableView!
    var toddlers : [Toddler] = []
    private let editViewControllerSegueIdentifier = "toEditKid"
    fileprivate let toddlerCellIdentifier = "ToddlersCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewKids.rowHeight = 70
        tableViewKids.delegate = self
        tableViewKids.dataSource = self
        toReloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toReloadData()
    }
    
    func toReloadData(){
        Manager.user.getToddlers(completion: { results in
            self.toddlers = results
            self.tableViewKids.reloadData()
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case editViewControllerSegueIdentifier:
            if let vc = segue.destination as? EnrollKidsTableViewController {
                let selectedIndexPath = self.tableViewKids.indexPathForSelectedRow!
                let selectedToddler = self.toddlers[selectedIndexPath.row]
                vc.currentToddler = selectedToddler
            }
            
        default:
                break
            }
    }

}
