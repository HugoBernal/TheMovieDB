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
    
}

class MovieFacade : MovieService {
    
    func fetchMovie(movieId id: Int, completionHandler: @escaping (Movies?) -> Void) {
        
        Alamofire.request("https://api.themoviedb.org/3/movie/\(id)?api_key=1f4d7de5836b788bdfd897c3e0d0a24b").responseJSON { (response) in
            print("Request: \(String(describing: response.request))") //original URL request
            print("Request: \(String(describing: response.response))") // HTTP URL response
            print("Result: \(response.result)") // Response serialization result
            
            if let json = response.result.value as? [String: Any] {
                print("JSON: \(json)") //Serialized JSON response
                
                let movie1 = Movies()
                movie1.originalTitle = json["original_title"] as! String
                movie1.overview = json["overview"] as! String
                movie1.id = json["id"] as! Int
                movie1.posterPath = json["poster_path"] as! String
                completionHandler(movie1)
                return
            }
            
            completionHandler(nil)
        }
}
    
    func fetchMoview(moviesIds ids: Int, completionHandler: @escaping ([Movies?]) -> Void) {
        //    func fetchMovie(movieId id: Int, completionHandler: @escaping (Movies?) -> Void) {
        //
        //        Alamofire.request("https://api.themoviedb.org/3/movie/\(id)?api_key=1f4d7de5836b788bdfd897c3e0d0a24b").responseJSON { (response) in
        //            print("Request: \(String(describing: response.request))") //original URL request
        //            print("Request: \(String(describing: response.response))") // HTTP URL response
        //            print("Result: \(response.result)") // Response serialization result
        //
        //            if let json = response.result.value as? [String: Any] {
        //                print("JSON: \(json)") //Serialized JSON response
        //
        //                let movie1 = Movies()
        //                movie1.originalTitle = json["original_title"] as! String
        //                movie1.overview = json["overview"] as! String
        //                movie1.id = json["id"] as! Int
        //                movie1.posterPath = json["poster_path"] as! String
        //                completionHandler(movie1)
        //                return
        //            }
        //
        //            completionHandler(nil)
        //        }
        //    }
    }
    
}
