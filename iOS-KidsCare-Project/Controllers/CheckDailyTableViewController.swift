//
//  CheckDailyTableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-07.
//

import UIKit

class CheckDailyTableViewController: UITableViewController {
    
    @IBOutlet weak var breakfastCheckLabel: UILabel!
    @IBOutlet weak var mainDishCheckLabel: UILabel!
    @IBOutlet weak var saladCheckLabel: UILabel!
    @IBOutlet weak var snackCheckLabel: UILabel!
    @IBOutlet weak var dessertsCheckLabel: UILabel!
    @IBOutlet weak var milkCheckLabel: UILabel!
    @IBOutlet weak var napCheckLabel: UILabel!

    var complete: Bool!
    var feed : Feed?
    var activityToday : Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aid = feed?.maid

        //buscar actividad y si no existe crearla desde cero
        Manager.user.getActivityById(aid: aid!, completion: { results in
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
            breakfastCheckLabel.text = currentBreakfast
            mainDishCheckLabel.text = currentMaindish
            saladCheckLabel.text = currentSalad
            snackCheckLabel.text = currentSnack
            dessertsCheckLabel.text = currentDessert
            milkCheckLabel.text = currentMilk
            napCheckLabel.text = currentNap
    }
}
