//
//  ViewController.swift
//  networkingHw2
//
//  Created by Field Employee on 10/2/20.
//

import UIKit

typealias ImageResult = (img: UIImage?, id: String?)

class ViewController: UIViewController {

    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUp()
        
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    let manager: NetworkManager
    
    init(manager: NetworkManager = NetworkManager()) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should not have happened. You done goofed!!!!")
    }

    func setUp() {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        //constraints
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        //assign
        self.tableView = tableView
        
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        manager.fetchImage { (tuple : ImageResult) in
            DispatchQueue.main.async {
                cell.imageView?.image = tuple.img
                cell.textLabel?.text = tuple.id
            }
        }
        
        return cell
    }
    
    
}
