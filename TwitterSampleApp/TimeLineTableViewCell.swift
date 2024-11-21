//
//  TimLineTableViewCell.swift
//  TwitterSampleApp
//
//  Created by 本坊康孝 on 2024/11/21.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(userName: String, detail: String) {
        nameLabel.text = userName
        detailLabel.text = detail
    }
}
