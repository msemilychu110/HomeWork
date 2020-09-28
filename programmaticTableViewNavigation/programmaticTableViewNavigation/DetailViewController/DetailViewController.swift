//
//  DetailViewController.swift
//  programmaticTableViewNavigation
//
//  Created by Field Employee on 9/28/20.
//

import UIKit

class DetailViewController: UIViewController {

    var imgView: UIImageView?
    var label: UILabel?
    var progressBar: UIProgressView?
    var slider: UISlider?
    
    var image: UIImage?
    var text: String?
    var progressNum: Float?
    var sliderNUm: Float?
    
    init(image: UIImage, text: String, progressNum: Float, sliderNum: Float){
        self.image = image
        self.text = text
        self.progressNum = progressNum
        self.sliderNUm = sliderNum
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
      setUP()
    }
    
 private func setUP() {

        //stackView
          //vStackView
         let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.distribution = .fillEqually
        vStackView.spacing = CGFloat(8)
        vStackView.axis = .vertical
        
       
        // label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        
        //imageView
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        
        //progressBar
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progress = progressNum ?? 0
        //slider
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = sliderNUm ?? 0 
        
        //add elements
        view.addSubview(vStackView)
        vStackView.addArrangedSubview(imageView)
        vStackView.addArrangedSubview(label)
        vStackView.addArrangedSubview(progressBar)
        vStackView.addArrangedSubview(slider)

        //constraints
           //vstack
    vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
           

    
                
        //assign elements
        self.imgView = imageView
        self.label = label
        self.progressBar = progressBar
        self.slider = slider
    }
}
