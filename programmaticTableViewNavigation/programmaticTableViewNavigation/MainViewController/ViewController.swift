//
//  ViewController.swift
//  programmaticTableViewNavigation
//
//  Created by Field Employee on 9/28/20.
//

import UIKit

class ViewController: UIViewController {
   
    var tableView: UITableView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUp()
        self.tableView?.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)

    }
    func setUp() {
        //tableView
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        //add element
        self.view.addSubview(tableView)
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        
        guard let progressNum = cell?.progressBar?.progress, let sliderNum = cell?.slider?.value, let image = cell?.imgView?.image, let text = cell?.label?.text else { return }
        
        let vc = DetailViewController(image: image, text: text, progressNum: progressNum, sliderNum: sliderNum)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
