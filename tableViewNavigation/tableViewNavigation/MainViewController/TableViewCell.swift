//
//  TableViewCell.swift
//  tableViewNavigation
//
//  Created by Field Employee on 9/26/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var tableViewCellImage: UIImageView!
    @IBOutlet weak var tableViewCellLabel: UILabel!
    @IBOutlet weak var tableViewCellProgress: UIProgressView!
    @IBOutlet weak var tableViewCellSlider: UISlider!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.tableViewCellImage.image = UIImage(named: "flower")
            self.tableViewCellLabel.text = "description la la la la "
        }
    }
    
    
    @IBAction func sliderPulled(_ sender: UISlider) {
        self.tableViewCellProgress.progress = sender.value
        self.tableViewCellSlider.setValue(sender.value, animated: true)
    }
    
    
}
