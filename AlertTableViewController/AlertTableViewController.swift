//
//  AlertTableViewController.swift
//  AlertTableViewController
//
//  Created by Nayem BJIT on 2/14/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit
import SDCAlertView

class AlertTableViewController: UIViewController {

    private var schedules = [String]()

    private var alert: AlertController!
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let tableViewCellHeight: CGFloat = 44.0

    public convenience init(schedules: [String]) {
        self.init()
        self.schedules = schedules
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = UIModalPresentationStyle.custom
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupAlertController()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        alert.present()
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alert.present()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .clear
        tableView.reloadData()
    }

    private func setupAlertController() {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let attributedTitle = NSAttributedString(string: "Schedules", attributes: attributes)
        alert = AlertController(attributedTitle: attributedTitle, attributedMessage: nil)
        let dismissAction = AlertAction(title: "Dismiss", style: .normal) { [unowned self] _ in
            self.dismiss(animated: false, completion: nil)
        }
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

        // Behaviour
//        alert.behaviors = .dismissOnOutsideTap

    }

}

extension AlertTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let schedule = schedules[indexPath.row]
        cell.textLabel?.text = "\(schedule) \(indexPath.row + 1)"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }

}

extension AlertTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert.dismiss(animated: true) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
