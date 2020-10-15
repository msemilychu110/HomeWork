//
//  TableViewCell.swift
//  coreDataHW
//
//  Created by Field Employee on 10/12/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        favoriteButton.alpha = 1.0
        UIView.animate(withDuration: 1.0, delay: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: {

            self.favoriteButton.alpha = 0.0
            self.favoriteButton.alpha = 1.0
        }, completion: nil)
    }
}
