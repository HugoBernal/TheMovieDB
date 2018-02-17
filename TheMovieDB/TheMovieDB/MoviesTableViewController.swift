//
//  MoviesTableViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesTableViewController: UIViewController {
    
    // MARK: - Properties
    
    let movieRequest : MovieService = MovieFacade()
    var moviesArray: [Movies]? = []
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpTableView()
        
        
    }

    // MARK: - Methods
    
    func setUpTableView() {
        
        movieRequest.fetchMovies { (movieResponse) in
            self.moviesArray = movieResponse?.results
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    


}


// MARK: - TableView DataSource

extension MoviesTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return moviesArray?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MoviesTableViewCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MoviesTableViewCell {
            
            let movie = moviesArray?[indexPath.row]
            
            cell.titleLabel.text = movie?.originalTitle
            cell.posterImage.af_setImage(withURL: URL(string: movie?.posterPath ?? "")!, placeholderImage: UIImage(named: "iTunesArtwork") , filter: nil, progress: nil, imageTransition: .flipFromTop(0.4), completion: nil)  //(withURL: URL(string: movie?.posterPath ?? "")!)
            cell.overviewLabel.text = movie?.overview
            
            return cell
        }
        
        fatalError("")
        
    }

    }



// MARK: - TableView Delegate

extension MoviesTableViewController: UITableViewDelegate {
    
}

