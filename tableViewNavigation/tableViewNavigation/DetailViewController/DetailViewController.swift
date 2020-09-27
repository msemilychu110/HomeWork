//
//  DetailViewController.swift
//  tableViewNavigation
//
//  Created by Field Employee on 9/26/20.
//

import UIKit

class DetailViewController: UIViewController, Info {
   
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailProgress: UIProgressView!
    @IBOutlet weak var detailSlider: UISlider!
    
    var text = ""
    var image = UIImage(named: "")
    var progress:Float = 0.0
    var slider:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.detailImage.image = self.image
            self.detailLabel.text = self.text
            self.detailProgress.progress = self.progress
            self.detailSlider.value = self.slider
        }
    }
    func infoTransmitter(image: UIImage, text: String, progressInt: Float, sliderInt: Float) {
        self.image = image
        self.text = text
        self.progress = progressInt
        self.slider = sliderInt
    }
}
    

