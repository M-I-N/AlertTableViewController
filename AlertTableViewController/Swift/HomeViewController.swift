//
//  HomeViewController.swift
//  AlertTableViewController
//
//  Created by Nayem BJIT on 2/14/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    /**
     Strong reference to picker object is a must because otherwise options in the picker aren't retained.
     
     Generic placeholder must be satisfied at the point of property declaration (in order to store a strong reference) because contextual information is passed through higher order function of initializer like:
     ```
     ... labels: ({ "\($0.name)'s ID: \($0.id)" }) ...
     ```
    */
    private var popover: PopoverPicker<Model>!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popupButtonDidTap(_ sender: UIButton) {
        
        let models = Model.allModels()
        popover = PopoverPicker(title: "Choose an Option", dismissButtonTitle: "Cancel", values: models, labels: ({ "\($0.name)'s ID: \($0.id)" }), onSelect: { [unowned self] selectedModel in
            self.performSegue(withIdentifier: "DetailSegue", sender: selectedModel)
        })
        popover.present()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue",
            let detailViewController = segue.destination as? DetailViewController,
            let model = sender as? Model {
                detailViewController.model = model
        }
        
    }

}
