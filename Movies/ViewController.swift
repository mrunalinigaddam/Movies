//
//  ViewController.swift
//  Movies
//
//  Created by Mrunalini on 07/11/20.
//  Copyright © 2020 Mrunalini. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private var movieData = [Movie]()
    var activityView = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieData()
        movieTableView.tableFooterView = UIView()
        activityView.center = self.view.center
        view.addSubview(activityView)
    }
    
    private func fetchMovieData() {
        activityView.startAnimating()
        let session = URLSession.shared
        let url = URL(string: "https://api.mocki.io/v1/8efc3049")!
        let task = session.dataTask(with: url, completionHandler: {[weak self] data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            do {
                let movieDataStore = try JSONDecoder().decode(MovieDataStore.self, from: data! )
                self?.movieData = movieDataStore.movies
                DispatchQueue.main.async {
                    self?.activityView.stopAnimating()
                    self?.movieTableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            if let indexPath = movieTableView.indexPathForSelectedRow {
                let detailsVC = segue.destination as! DetailsViewController
                detailsVC.movie = movieData[indexPath.row]
            }
        }
    }
}


    extension ViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movieData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
            cell.name?.text = movieData[indexPath.row].name
            if let imgUrl = URL(string: movieData[indexPath.row].url) {
                cell.imgView.kf.setImage(with: imgUrl)
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "details", sender: self)
        }
    }
