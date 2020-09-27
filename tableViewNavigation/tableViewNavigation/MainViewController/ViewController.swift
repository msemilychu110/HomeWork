//
//  ViewController.swift
//  tableViewNavigation
//
//  Created by Field Employee on 9/26/20.
//

import UIKit

protocol Info {
    func infoTransmitter(image: UIImage, text: String, progressInt: Float, sliderInt: Float)
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegation: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }


}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        self.delegation = vc as? Info
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        if let image = cell?.tableViewCellImage.image, let text = cell?.tableViewCellLabel.text, let progressInt = cell?.tableViewCellProgress.progress, let sliderInt = cell?.tableViewCellSlider.value {
            delegation?.infoTransmitter(image: image, text: text, progressInt: progressInt, sliderInt: sliderInt)
        }

        self.navigationController?.pushViewController(vc,animated: true)
        
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
