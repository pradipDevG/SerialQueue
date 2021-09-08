//
//  TableCell.swift
//  SerialQueue
//
//  Created by Pradip Gotame on 07/09/2021.
//

import UIKit
import SDWebImage

class BaseTableCell<T>: UITableViewCell {
    var model: T!
}

class TableCell: BaseTableCell<URLs> {

    @IBOutlet weak var favIcon: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var lengthLabel: UILabel!
    
    override var model: URLs! {
        didSet {
            if model.error.isEmpty {
                favIcon.sd_setImage(with: URL(string:  model.favIcon), placeholderImage: nil)
            } else {
                favIcon.image = UIImage(named: "error.png")
            }
            
            titleLabel.text = model.url
            lengthLabel.text = model.cLength
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
