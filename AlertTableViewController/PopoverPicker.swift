//
//  PopoverPicker.swift
//  AlertTableViewController
//
//  Created by Nayem on 2/15/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit
import SDCAlertView

class PopoverPicker<Element>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    typealias SelectionHandler = (Element) -> Void
    typealias LabelProvider = (Element) -> String
    
    private let title: String!
    private let dismissButtonTitle: String!
    private let values : [Element]
    private let labels : LabelProvider?
    private let onSelect : SelectionHandler?
    
    private var alertController: AlertController!
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let tableViewCellHeight: CGFloat = 135/3
    
    init(title: String = "Picker Options", dismissButtonTitle: String = "Dismiss", values: [Element], labels: LabelProvider? = String.init(describing:), onSelect: SelectionHandler?) {
        self.title = title
        self.dismissButtonTitle = dismissButtonTitle
        self.values = values
        self.onSelect = onSelect
        self.labels = labels
        super.init()
        setupTableView()
        setupAlertController()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerReusableCell(PopoverPickerTableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.reloadData()
        tableView.rowHeight = tableViewCellHeight
        tableView.separatorInset = .zero
    }
    
    private func setupAlertController() {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        alertController = AlertController(attributedTitle: attributedTitle, attributedMessage: nil)
        let dismissAction = AlertAction(title: dismissButtonTitle, style: .normal)
        alertController.addAction(dismissAction)
        
        // Custom content view
        let separatorAboveTableView = UIView(frame: .zero)
        separatorAboveTableView.translatesAutoresizingMaskIntoConstraints = false
        alertController.contentView.addSubview(separatorAboveTableView)
        
        separatorAboveTableView.leadingAnchor.constraint(equalTo: alertController.contentView.leadingAnchor).isActive = true
        separatorAboveTableView.trailingAnchor.constraint(equalTo: alertController.contentView.trailingAnchor).isActive = true
        separatorAboveTableView.topAnchor.constraint(equalTo: alertController.contentView.topAnchor).isActive = true
        separatorAboveTableView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        separatorAboveTableView.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        alertController.contentView.addSubview(tableView)
        
        let maximumNumberOfCellToBeVisible = 3
        let numberOfVisibleCell = values.count < maximumNumberOfCellToBeVisible ? values.count : maximumNumberOfCellToBeVisible
        let tableViewMaxHeight = tableViewCellHeight * CGFloat(numberOfVisibleCell) // needs logic
        tableView.leadingAnchor.constraint(equalTo: alertController.contentView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: alertController.contentView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: separatorAboveTableView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: alertController.contentView.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: tableViewMaxHeight).isActive = true
        
        // Appearance
//        alert.contentView.tintColor = .white
        let visualStyle = AlertVisualStyle(alertStyle: .alert)
        visualStyle.backgroundColor = .black
        visualStyle.normalTextColor = .white
        visualStyle.verticalElementSpacing = (visualStyle.verticalElementSpacing * 47) / 80
        visualStyle.contentPadding.top = 32 // (visualStyle.contentPadding.top * 16) / 20
        visualStyle.contentPadding.bottom = 0
        visualStyle.contentPadding.left = 0
        visualStyle.contentPadding.right = 0
        alertController.visualStyle = visualStyle
        
        alertController.behaviors = .dismissOnOutsideTap
    }
    
    func present() {
        alertController.present()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PopoverPickerTableViewCell.dequeue(fromTableView: tableView, atIndex: indexPath)
        let value = values[indexPath.row]
        let label = labels?(value)
        cell.titleLabel.text = label
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alertController.dismiss { [weak self] in
            guard let `self` = self else { return }
            let value = self.values[indexPath.row]
            self.onSelect?(value)
        }
    }
    
}
