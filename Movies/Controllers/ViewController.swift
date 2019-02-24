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
    var myMovies = [Movie]()
    var posterImages = [String: UIImage]()
    var movieSegment = MovieType.AllMovies
    var currentPage = 0
    var totalPages = 0
    var addView = UIView()
    var addImage = UIButton()
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

    // when there is no data result not found message setup
    var notFound = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width / 4, y: UIScreen.main.bounds.size.height / 3, width: UIScreen.main.bounds.size.width / 2, height: 30))
    func NotFoundAction(_ show: Bool){
        notFound.textAlignment = .center
        notFound.text = "No Result Found."
        notFound.textColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        if show{
            view.addSubview(notFound)
        }else{
            notFound.removeFromSuperview()
        }
    }
    
    // change movies type
    @IBAction func ChangeMovieSegment(_ sender: UISegmentedControl) {
        self.addView.isHidden = true
        self.NotFoundAction(false) // remove from the new view
        switch sender.selectedSegmentIndex {
        case 1:
            self.movieSegment = MovieType.MyMovies
            self.checkData(count: self.myMovies.count)
        default:
            self.movieSegment = MovieType.AllMovies
            self.checkData(count: self.movies.count)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func AddMovie(_ sender: UIBarButtonItem) {
        let newIndex = String(self.myMovies.count)
        (self.addView, self.addImage) = addNewMovie(viewController: self,view: self.view, index: newIndex, completionHandler: { (movie, posterImage) in
            self.myMovies.append(movie)
            self.posterImages[newIndex] = posterImage
            self.tableView.reloadData()
            self.checkData(count: self.myMovies.count)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //web connection
        activityIndecator.startAnimating()
        self.loadMoreData()
        activityIndecator.stopAnimating()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // to remove additional lines separators
        tableView.tableFooterView = UIView()
    }
    
    // load more data from server for allmovies
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
    
    // check found data
    func checkData(count: Int){
        if count == 0{
            self.NotFoundAction(true)
        }else{
            self.NotFoundAction(false)
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("#",self.movies.count)
        switch movieSegment{
        case MovieType.MyMovies:
            return self.myMovies.count
        default:
            return self.movies.count
        }
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
        switch movieSegment{
        case MovieType.MyMovies:
            cell.title.text = self.myMovies[indexPath.row].title
            cell.overview.text = self.myMovies[indexPath.row].overview
            cell.date.text = self.myMovies[indexPath.row].date
            let posterIndex = self.myMovies[indexPath.row].poster
            cell.posterImage.image = self.posterImages[posterIndex]
        default:
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
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.4
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // to load more data from server
        if self.movieSegment == MovieType.AllMovies{
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
    
}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let image_data = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        //        let imageData: Data = UIImagePNGRepresentation(image_data!)!
        //        let imageString = imageData.base64EncodedString()
        //        let image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        let newIndex = self.myMovies.count
        self.posterImages[String(newIndex)] = image_data
        self.addImage.setImage(image_data, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
