//
//  ViewController.swift
//  Movies
//
//  Created by Shimaa Hassan on 2/22/19.
//  Copyright © 2019 Shimaa Hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movies = [Movie]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        //web connection
        WebService.share.webConnection(urlString: movies_url) { result in
            //            print(result)
            for dict in result{
                self.movies.append(Movie(title: dict["title"] as? String ?? "", overview: dict["overview"] as? String ?? "", poster: dict["poster_path"] as? String ?? "", date: dict["release_date"] as? String ?? ""))
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // to remove additional lines separators
        tableView.tableFooterView = UIView()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("###",self.movies.count)
        return self.movies.count
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
        
        // fill cell
        cell.title.text = self.movies[indexPath.row].title
        cell.overview.text = self.movies[indexPath.row].overview
        cell.date.text = self.movies[indexPath.row].date
        
        return cell
    }
    
}
