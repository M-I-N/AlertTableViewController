//
//  ViewController.swift
//  AlertTableViewController
//
//  Created by Nayem BJIT on 2/14/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit
import SDCAlertView

class ViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .plain)
    private let tableViewCellHeight: CGFloat = 44.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        tableView.reloadData()
        tableView.backgroundColor = .clear
    }

    @IBAction func showAlertButtonDidTap(_ sender: UIButton) {

        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let attributedTitle = NSAttributedString(string: "Schedules", attributes: attributes)
        let alert = AlertController(attributedTitle: attributedTitle, attributedMessage: nil)
        let dismissAction = AlertAction(title: "Dismiss", style: .normal)
        alert.addAction(dismissAction)

        // Custom content view
        tableView.translatesAutoresizingMaskIntoConstraints = false
        alert.contentView.addSubview(tableView)

        tableView.leadingAnchor.constraint(equalTo: alert.contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: alert.contentView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: alert.contentView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: tableViewCellHeight * 5).isActive = true

        // Appearance
        alert.contentView.tintColor = .white
        let visualStyle = AlertVisualStyle(alertStyle: .alert)
        visualStyle.backgroundColor = .black
        visualStyle.normalTextColor = .white
        alert.visualStyle = visualStyle

//        alert.present()
        present(alert, animated: true)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Item \(indexPath.row + 1)"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }


}
