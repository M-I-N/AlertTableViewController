//
//  HomeViewController.swift
//  AlertTableViewController
//
//  Created by Nayem BJIT on 2/14/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private var alertTableView: AlertTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func popupButtonDidTap(_ sender: UIButton) {
        let schedules = ["Schedule", "Schedule", "Schedule", "Schedule"]
        alertTableView = AlertTableView(schedules: schedules)
        alertTableView.present()
//        let alertTVC = AlertTableViewController(schedules: schedules)
//        present(alertTVC, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
