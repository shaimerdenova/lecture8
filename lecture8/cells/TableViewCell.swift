//
//  TableViewCell.swift
//  lecture8
//
//  Created by admin on 12.02.2021.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet var temp: UILabel!
    @IBOutlet var image1: UIImageView!
    @IBOutlet var day: UILabel!
    @IBOutlet var feelsLike: UILabel!
    static let identifier = String(describing: TableViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
