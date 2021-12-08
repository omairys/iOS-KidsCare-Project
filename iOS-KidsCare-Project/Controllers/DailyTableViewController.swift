//
//  DailyTableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-05.
//

import UIKit

class DailyTableViewController: UITableViewController {
    
    @IBOutlet weak var breakfastLabel: UILabel!
    @IBOutlet weak var mainDishLabel: UILabel!
    @IBOutlet weak var saladLabel: UILabel!
    @IBOutlet weak var snackLabel: UILabel!
    @IBOutlet weak var dessertsLabel: UILabel!
    @IBOutlet weak var milkLabel: UILabel!
    @IBOutlet weak var napLabel: UILabel!

    var complete: Bool!
    var toddler : Toddler?
    var nameToddler : String?
    var currentIdToddler : String?
    var currentIdActivity : String?
    var activityToday : Activity?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = nameToddler
        //buscar actividad y si no existe crearla desde cero
        Manager.user.getActivityById(aid: currentIdActivity!, completion: { results in
            self.activityToday = results
            self.setUIValues()
        })
    }
    
    
    func setUIValues(){
        guard
            let currentBreakfast = self.activityToday?.mBreakfast,
            let currentSalad = self.activityToday?.mSalad,
            let currentMaindish = self.activityToday?.mMaindish,
            let currentDessert = self.activityToday?.mDessert,
            let currentSnack = self.activityToday?.mSnack,
            let currentMilk = self.activityToday?.mMilk,
            let currentNap = self.activityToday?.mNap
        else {
                return
            }
            breakfastLabel.text = currentBreakfast
            mainDishLabel.text = currentMaindish
            saladLabel.text = currentSalad
            snackLabel.text = currentSnack
            dessertsLabel.text = currentDessert
            milkLabel.text = currentMilk
            napLabel.text = currentNap
    }
    
    
    //gestiona las alertas
    func displayAlert(title: String, message:String){
        let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log("the selected section is: \(indexPath.section)")
        
        //breakfast
        if indexPath.section == 0 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .alert, title: "Breakfast", message: "How many?")
            alert.addAction(title: "1/4", style: .default){ action in self.breakfastLabel.text = action.title }
            alert.addAction(title: "2/4", style: .default){ action in self.breakfastLabel.text = action.title }
            alert.addAction(title: "3/4", style: .default){ action in self.breakfastLabel.text = action.title }
            alert.addAction(title: "4/4", style: .default){ action in self.breakfastLabel.text = action.title }
            alert.addAction(title: "Cancel", style: .cancel){ action in self.breakfastLabel.text = "Select" }
            alert.show()
        }
        //non
        if indexPath.section == 1 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .alert, title: "Main Dish", message: "How many?")
            alert.addAction(title: "1/4", style: .default){ action in self.mainDishLabel.text = action.title }
            alert.addAction(title: "2/4", style: .default){ action in self.mainDishLabel.text = action.title }
            alert.addAction(title: "3/4", style: .default){ action in self.mainDishLabel.text = action.title }
            alert.addAction(title: "4/4", style: .default){ action in self.mainDishLabel.text = action.title }
            alert.addAction(title: "Cancel", style: .cancel){ action in self.mainDishLabel.text = "Select" }
            alert.show()
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .alert, title: "Salad", message: "How many?")
            alert.addAction(title: "1/4", style: .default){ action in self.saladLabel.text = action.title }
            alert.addAction(title: "2/4", style: .default){ action in self.saladLabel.text = action.title }
            alert.addAction(title: "3/4", style: .default){ action in self.saladLabel.text = action.title }
            alert.addAction(title: "4/4", style: .default){ action in self.saladLabel.text = action.title }
            alert.addAction(title: "Cancel", style: .cancel){ action in self.saladLabel.text = "Select" }
            alert.show()
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .alert, title: "Desserts", message: "How many?")
            alert.addAction(title: "1/4", style: .default){ action in self.dessertsLabel.text = action.title }
            alert.addAction(title: "2/4", style: .default){ action in self.dessertsLabel.text = action.title }
            alert.addAction(title: "3/4", style: .default){ action in self.dessertsLabel.text = action.title }
            alert.addAction(title: "4/4", style: .default){ action in self.dessertsLabel.text = action.title }
            alert.addAction(title: "Cancel", style: .cancel){ action in self.dessertsLabel.text = "Select" }
            alert.show()
        }
        
        //afternoon
        if indexPath.section == 2 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .alert, title: "Snack", message: "How many?")
            alert.addAction(title: "1/4", style: .default){ action in self.snackLabel.text = action.title }
            alert.addAction(title: "2/4", style: .default){ action in self.snackLabel.text = action.title }
            alert.addAction(title: "3/4", style: .default){ action in self.snackLabel.text = action.title }
            alert.addAction(title: "4/4", style: .default){ action in self.snackLabel.text = action.title }
            alert.addAction(title: "Cancel", style: .cancel){ action in self.snackLabel.text = "Select" }
            alert.show()
        }
        
        if indexPath.section == 2 && indexPath.row == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .alert, title: "Milk", message: "How many?")
            alert.addAction(title: "1/4", style: .default){ action in self.milkLabel.text = action.title }
            alert.addAction(title: "2/4", style: .default){ action in self.milkLabel.text = action.title }
            alert.addAction(title: "3/4", style: .default){ action in self.milkLabel.text = action.title }
            alert.addAction(title: "4/4", style: .default){ action in self.milkLabel.text = action.title }
            alert.addAction(title: "Cancel", style: .cancel){ action in self.milkLabel.text = "Select" }
            alert.show()
        }
        
        //other
        if indexPath.section == 3 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .alert, title: "Nap", message: "How many?")
            alert.addAction(title: "1/2", style: .default){ action in self.napLabel.text = action.title }
            alert.addAction(title: "1", style: .default){ action in self.napLabel.text = action.title }
            alert.addAction(title: "1 1/2", style: .default){ action in self.napLabel.text = action.title }
            alert.addAction(title: "2", style: .default){ action in self.napLabel.text = action.title }
            alert.addAction(title: "Cancel", style: .cancel){ action in self.napLabel.text = "Select" }
            alert.show()
        }
        
        if indexPath.section == 3 && indexPath.row == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
            print("Completa el registro")
            saveActivity(complete: true)
        }
    }
    
    func saveActivity(complete: Bool){
        //create new activity
        Manager.activity.createNewActivity(
            aid: currentIdActivity!,
            kid: currentIdToddler!,
            breakfast: self.breakfastLabel.text!,
            salad: self.saladLabel.text!,
            maindish: self.mainDishLabel.text!,
            dessert: self.dessertsLabel.text!,
            snack: self.snackLabel.text!,
            milk: self.milkLabel.text!,
            nap: self.napLabel.text!,
            complete: complete,
            date: String(Date().year)+String(Date().month)+String(Date().day),
            completion: {check in if check {
                print("new activity has been create")
                }
                else {
                    self.displayAlert(title: "Could not enroll this kid", message: "unknow error")
                }
            })
        updateFeed()
        
        
    }
    
    func updateFeed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyyMMddhhmmss"
        let dateString2 = dateFormatter2.string(from: Date())

        //create new feed
        Manager.feed.createNewFeed(
            idf: DefaultData.user.mUid!+dateString2+"3",
            title: DefaultData.user.mName!+" "+DefaultData.user.mLastname!,
            description: "The daily registration has been completed for " + nameToddler!,
            visibility: DefaultData.user.mClassroom!,
            associatedImage: "",
            userImage: DefaultData.user.mImageUrl!,
            requiredAction: "NO",
            author: DefaultData.user.mUid!,
            date: dateString,
            kid: currentIdToddler!,
            aid: currentIdActivity!,
            completion: {check in if check {
                print("information was added to the feed")
                }
                else {
                    self.displayAlert(title: "No information could be added to the feed", message: "unknow error")
                }
            })
            
        //create new feed for parent
        Manager.feed.createNewFeed(
            idf: DefaultData.user.mUid!+dateString2+"4",
            title: (toddler?.mName)!+" "+" "+(toddler?.mLastname)!,
            description: "The daily registration has been completed for " + nameToddler!,
            visibility: (toddler?.mParentId)!,
            associatedImage: "",
            userImage: (toddler?.mImageUrl)!,
            requiredAction: "checkout",
            author: DefaultData.user.mUid!,
            date: dateString,
            kid: (toddler?.mUid)!,
            aid: currentIdActivity!,
            completion: {check in if check {
                print("information was added to the feed")
                }
                else {
                    self.displayAlert(title: "No information could be added to the feed", message: "unknow error")
                }
            })
        navigationController?.popViewController(animated: true)
        
    }
}
