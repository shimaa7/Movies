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
    var currentPage = 0
    var totalPages = 0
    @IBOutlet weak var tableView: UITableView!
    
    // activity indicator setup
    let activityIndecator: UIActivityIndicatorView = UIActivityIndicatorView()
    func setupActivityLoading(){
        //                        activity indecator
        activityIndecator.center = self.view.center
        activityIndecator.hidesWhenStopped = true
        activityIndecator.style = UIActivityIndicatorView.Style.gray
        activityIndecator.transform = CGAffineTransform(scaleX: 4, y: 4)
        view.addSubview(activityIndecator)
    }

    override func viewWillAppear(_ animated: Bool) {
        //web connection
        activityIndecator.startAnimating()
        self.loadMoreData()
        activityIndecator.stopAnimating()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // to remove additional lines separators
        tableView.tableFooterView = UIView()
    }
    
    func loadMoreData(){
        self.currentPage += 1
        WebService.share.webConnection(urlString: movies_url + "&page=\(currentPage)") { result,noOfPages  in
            //            print(result)
            self.totalPages = noOfPages
            for dict in result{
                self.movies.append(Movie(title: dict["title"] as? String ?? "", overview: dict["overview"] as? String ?? "", poster: dict["poster_path"] as? String ?? "", date: dict["release_date"] as? String ?? ""))
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("#",self.movies.count)
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
        spaceView.leftAnchor.constraint(equalTo: cell.leftAnchor),
        spaceView.rightAnchor.constraint(equalTo: cell.rightAnchor),
        spaceView.heightAnchor.constraint(equalToConstant: 0.9),
        ])
        
        // fill cell
        cell.title.text = self.movies[indexPath.row].title
        cell.overview.text = self.movies[indexPath.row].overview
        cell.date.text = self.movies[indexPath.row].date
        if self.movies[indexPath.row].poster != ""{
            let imageURL = (image_url + self.movies[indexPath.row].poster)
            cell.posterImage.downloadedFrom(link: imageURL)
            get_image(imageURL, cell.posterImage) //loadImage
        }else{
            cell.posterImage.image = #imageLiteral(resourceName: "movies_poster")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.4
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex && lastRowIndex + 1 != self.totalPages{
//             print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            
            self.loadMoreData()
            spinner.stopAnimating()
        }
    }
    
}
