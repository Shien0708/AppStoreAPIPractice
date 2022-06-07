//
//  TopChartViewController.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/6.
//

import UIKit

class TopChartViewController: UIViewController {
    
    @IBOutlet weak var freeAppsView: UIView!
    @IBOutlet weak var paidAppsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changePage(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            freeAppsView.isHidden = false
            paidAppsView.isHidden = true
        } else {
            freeAppsView.isHidden = true
            paidAppsView.isHidden = false
        }
    }
    

}
