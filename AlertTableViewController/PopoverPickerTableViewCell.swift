//
//  PopoverPickerTableViewCell.swift
//  AlertTableViewController
//
//  Created by Nayem on 2/15/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import UIKit

class PopoverPickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal static func dequeue(fromTableView tableView: UITableView, atIndex index: IndexPath) -> PopoverPickerTableViewCell {
        guard let cell: PopoverPickerTableViewCell = tableView.dequeueReusableCell(indexPath: index) else {
            fatalError("*** Failed to dequeue CollectionViewCell ***")
        }
        return cell
    }
    
}
