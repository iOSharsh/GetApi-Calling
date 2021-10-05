//
//  VcTableViewCell.swift
//  JsonDemoUsingSwiftyJson
//
//  Created by mac on 29/01/21.
//

import UIKit

class VcTableViewCell: UITableViewCell {

    @IBOutlet weak var artistName:UILabel!
    @IBOutlet weak var artistId:UILabel!
    @IBOutlet weak var viewBG:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
