//
//  ProfileTeacherTableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-05.
//

import UIKit

class ProfileTeacherTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("the selected section is: \(indexPath.section)")
        
        if indexPath.section == 0 && indexPath.row == 1 {
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "email")
            defaults.removeObject(forKey: "userid")
            defaults.removeObject(forKey: "type")
            defaults.removeObject(forKey: "classroom")
            defaults.synchronize()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
        }
    
    }

}
