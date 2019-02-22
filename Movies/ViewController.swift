//
//  ViewController.swift
//  Movies
//
//  Created by Shimaa Hassan on 2/22/19.
//  Copyright © 2019 Shimaa Hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.tableFooterView = UIView() // to remove additional lines separators
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath) as! MoviesTableViewCell
        
        // custom separator
        let spaceView = UIView()
        spaceView.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        cell.addSubview(spaceView)
        
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        spaceView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
        spaceView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
        spaceView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
        spaceView.heightAnchor.constraint(equalToConstant: 0.9),
        spaceView.topAnchor.constraint(equalTo: cell.posterImage.bottomAnchor, constant: 20)
        ])
        
        return cell
    }
    
}
