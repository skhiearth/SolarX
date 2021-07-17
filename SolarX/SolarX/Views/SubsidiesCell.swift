//
//  SubsidiesCell.swift
//  SolarX
//
//  Created by Utkarsh Sharma on 17/07/21.
//

import UIKit

class SubsidiesCell: UITableViewCell {

    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
