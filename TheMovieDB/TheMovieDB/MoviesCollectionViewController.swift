//
//  MoviesCollectionViewController.swift
//  TheMovieDB
//
//  Created by Hugo Bernal on Feb/14/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UIViewController {
    
    // MARK: - Properties
    
    let movieRequest: MovieService = MovieFacade()
    var moviesCollection: [Movies]? = []
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 10) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        setUpCollectionView()
        
    }
    
    // MARK: - Methods
    
    func setUpCollectionView() {
        movieRequest.fetchMovies { (movieResponse) in
            self.moviesCollection = movieResponse?.results
            self.collectionView.reloadData()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

}

// MARK: - DataSource

extension MoviesCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesCollection?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "MoviesCollectionViewCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MoviesCollectionViewCell, let movie = moviesCollection?[indexPath.item] else {
            fatalError("")
        }
        
        cell.titleLabel.text = movie.originalTitle
        cell.posterImage.af_setImage(withURL: URL(string:movie.posterPath )!, placeholderImage: UIImage(named: "iTunesArtwork"), filter: nil, progress: nil, imageTransition: .flipFromTop(0.4), completion: nil)
        
        return cell
        
    }
    
}

// MARK: - Delegate

extension MoviesCollectionViewController: UICollectionViewDelegate {
    
}
