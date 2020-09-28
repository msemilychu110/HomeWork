//
//  TableViewCell.swift
//  programmaticTableViewNavigation
//
//  Created by Field Employee on 9/28/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseId = "CustomTableViewCell"
    
    var imgView: UIImageView?
    var label: UILabel?
    var progressBar: UIProgressView?
    var slider: UISlider?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        //stackView
          //vStackView
         let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.distribution = .fillEqually
        vStackView.spacing = CGFloat(8)
        vStackView.axis = .vertical
        
          //hStackView
         let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .fillEqually
        hStackView.spacing = CGFloat(8)
        hStackView.alignment = .center
        hStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
       
        // label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "lalala"
        
        
        //imageView
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "flower")
        
        //progressBar
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        //slider
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderPUlled), for: .valueChanged)
        //add elements
        contentView.addSubview(hStackView)
        hStackView.addArrangedSubview(imageView)
        hStackView.addArrangedSubview(vStackView)
        vStackView.addArrangedSubview(label)
        vStackView.addArrangedSubview(progressBar)
        vStackView.addArrangedSubview(slider)

        //constraints
           //hstack
        hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
           
           //vstack
    
                
        //assign elements
        self.imgView = imageView
        self.label = label
        self.progressBar = progressBar
        self.slider = slider
    }
    @objc func sliderPUlled(sender: UISlider) {
        slider?.value = sender.value
        progressBar?.progress = sender.value
    }
}
