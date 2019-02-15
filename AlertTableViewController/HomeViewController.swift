//
//  HomeViewController.swift
//  AlertTableViewController
//
//  Created by Nayem BJIT on 2/14/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private var alertTableView: AlertTableView<Model>!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popupButtonDidTap(_ sender: UIButton) {
        let models = Model.allModels()
        alertTableView = AlertTableView(values: models, labels: ({ "\($0.name)'s ID: \($0.id)" }), onSelect: { model in
            print(model)
        })
        alertTableView.present()
    }

}
