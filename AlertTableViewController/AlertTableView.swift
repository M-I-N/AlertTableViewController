//
//  AlertTableViewController.swift
//  AlertTableViewController
//
//  Created by Nayem BJIT on 2/14/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit
import SDCAlertView

class AlertTableView<Element>: UIView, UITableViewDataSource {

//    private var schedules = [String]()
    typealias SelectionHandler = (Element) -> Void
    typealias LabelProvider = (Element) -> String
    
    private var values = [Element]()
    private var labels: LabelProvider?
    private var onSelect: SelectionHandler?

    private var alert: AlertController!
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let tableViewCellHeight: CGFloat = 135/3

    convenience init(values : [Element], labels : @escaping LabelProvider = String.init(describing:), onSelect : SelectionHandler?) {
        self.init(frame: .zero)
        self.values = values
        self.labels = labels
        self.onSelect = onSelect
        setupTableView()
        setupAlertController()
    }

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .clear
        tableView.reloadData()
        tableView.rowHeight = tableViewCellHeight
        tableView.separatorInset = .zero
    }

    private func setupAlertController() {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSAttributedString(string: "Schedules", attributes: attributes)
        alert = AlertController(attributedTitle: attributedTitle, attributedMessage: nil)
        let dismissAction = AlertAction(title: "Dismiss", style: .normal)
        alert.addAction(dismissAction)

        // Custom content view
        let separatorAboveTableView = UIView(frame: .zero)
        separatorAboveTableView.translatesAutoresizingMaskIntoConstraints = false
        alert.contentView.addSubview(separatorAboveTableView)

        separatorAboveTableView.leadingAnchor.constraint(equalTo: alert.contentView.leadingAnchor).isActive = true
        separatorAboveTableView.trailingAnchor.constraint(equalTo: alert.contentView.trailingAnchor).isActive = true
        separatorAboveTableView.topAnchor.constraint(equalTo: alert.contentView.topAnchor).isActive = true
        separatorAboveTableView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        separatorAboveTableView.backgroundColor = .white

        tableView.translatesAutoresizingMaskIntoConstraints = false
        alert.contentView.addSubview(tableView)

        let maximumNumberOfCellToBeVisible = 3
        let numberOfVisibleCell = values.count < maximumNumberOfCellToBeVisible ? values.count : maximumNumberOfCellToBeVisible
        let tableViewMaxHeight = tableViewCellHeight * CGFloat(numberOfVisibleCell) // needs logic
        tableView.leadingAnchor.constraint(equalTo: alert.contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: alert.contentView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: separatorAboveTableView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: tableViewMaxHeight).isActive = true

        // Appearance
        alert.contentView.tintColor = .white
        let visualStyle = AlertVisualStyle(alertStyle: .alert)
        visualStyle.backgroundColor = .black
        visualStyle.normalTextColor = .white
        visualStyle.verticalElementSpacing = (visualStyle.verticalElementSpacing * 47) / 80
        visualStyle.contentPadding.top = 32 // (visualStyle.contentPadding.top * 16) / 20
        visualStyle.contentPadding.bottom = 0
        visualStyle.contentPadding.left = 0
        visualStyle.contentPadding.right = 0
        alert.visualStyle = visualStyle

        alert.behaviors = .dismissOnOutsideTap
    }

    func present() {
        alert.present()
    }

    func dismiss() {
        alert.dismiss()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let value = values[indexPath.row]
        let label = labels?(value)
        cell.textLabel?.text = label
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }

}
