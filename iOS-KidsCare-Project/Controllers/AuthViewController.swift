//
//  AuthViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-11-25.
//

import UIKit
import Firebase
import FirebaseAuth

class AuthViewController: UIViewController {
    let ref = Database.database().reference()
    var userType = ""
    
    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        clearDefaultData()
        
        // Do any additional setup after loading the view.
    }
    
    private func clearDefaultData() {
        //clear data
    }
    @IBAction func loginButtonAct(_ sender: Any) {
        if let email = email_tf.text, let password = password_tf.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let result = result, error == nil {

                    //let userID = Auth.auth().currentUser?.uid
                    let uid = result.user.uid
                    DefaultData.user.ditinit(id: uid, completion: {
                        let typeUserAuth = DefaultData.user.mUserType!
                        let classRoom = DefaultData.user.mClassroom!
                        if typeUserAuth == "teacher" {
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTeachTabBarController")
                            
                            // This is to get the SceneDelegate object from your view controller
                            // then call the change root view controller function to change to main tab bar
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                        
                        } else {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainParentTabBarController")
                            
                            // This is to get the SceneDelegate object from your view controller
                            // then call the change root view controller function to change to main tab bar
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                        }
                        
                        let defaults = UserDefaults.standard
                        defaults.set(email, forKey: "email")
                        defaults.set(uid, forKey: "userid")
                        defaults.set(typeUserAuth, forKey: "type")
                        defaults.set(classRoom, forKey: "classroom")
                        defaults.synchronize()
                    })
                    
                } else {
                    let alertController =  UIAlertController(title: "Error", message: "An error occurred when trying to log in", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
}
