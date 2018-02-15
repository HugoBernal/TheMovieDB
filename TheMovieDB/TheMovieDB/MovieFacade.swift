//
//  MovieFacade.swift
//  TheMovieDB
//
//  Created by Hugo Bernal on Feb/6/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation
import Alamofire

protocol  MovieService {
    
    func fetchMovie(movieId id: Int, completionHandler: @escaping (Movies?) -> Void)
    func fetchMovies(completionHandler: @escaping (MovieResponse?) -> Void)
    
}

class MovieFacade : MovieService {
    
    let baseURL = "https://api.themoviedb.org/3"
    let APIKey = "api_key=1f4d7de5836b788bdfd897c3e0d0a24b"
    
    
    func fetchMovie(movieId id: Int, completionHandler: @escaping (Movies?) -> Void) {
        
        Alamofire.request( baseURL + "/movie/\(id)?" + APIKey).responseJSON { (response) in
            print("Request: \(String(describing: response.request))") //original URL request
            print("Request: \(String(describing: response.response))") // HTTP URL response
            print("Result: \(response.result)") // Response serialization result
            
            if let json = response.result.value as? [String: Any] {
                print("JSON: \(json)") //Serialized JSON response
                
                completionHandler(self.parseMovie(json: json))
                return
            }
            
            completionHandler(nil)
        }
}
    
    func fetchMovies(completionHandler: @escaping (MovieResponse?) -> Void) {
        Alamofire.request( baseURL + "/movie/now_playing?" + APIKey).responseJSON { (response) in
            print("Result: \(response.result)") //Response serialization result
            guard let json = response.result.value as? [String: Any],
                let values = json["results"] as? [[String: Any]] else {
                    completionHandler(nil)
                    return
            }
            
            var JSONResponse = MovieResponse()
            let mappedMovies = values.map { rawMovie in
                return self.parseMovie(json: rawMovie)
            }
            
            print("JSON: \(json)") // Serialized JSON response
            
            JSONResponse.results = mappedMovies
            JSONResponse.page = json["page"] as! Int
            JSONResponse.totalResults = json["total_results"] as! Int
            JSONResponse.totalPages = json["total_pages"] as! Int
            
            completionHandler(JSONResponse)
        }
    }
    
    func parseMovie(json: [String: Any]) -> Movies {
        
        let movie = Movies()
        
        movie.originalTitle = json["original_title"] as! String
        movie.overview = json["overview"] as! String
        movie.id = json["id"] as! Int
        movie.posterPath = "https://image.tmdb.org/t/p/w500" + (json["poster_path"] as! String)
        
        return movie
        
    }
    
}
