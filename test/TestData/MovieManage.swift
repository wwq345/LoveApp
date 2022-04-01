//
//  MovieManage.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/2/27.
//

import Foundation

class MovieManager{
    var moviesToSeeCount: Int { return moviesToSeeArray.count}
    var moviesBeSawCount: Int {return moviesBeSawArray.count}
    
    private var moviesToSeeArray = [Movie]()
    private var moviesBeSawArray = [Movie]()
    
    
    func addMovie(movie: Movie){
        if !moviesToSeeArray.contains(movie){
            moviesToSeeArray.append(movie)
           
        }
        
    }
    
    func checkOffMovieAtIndex(index: Int){
        guard index < moviesToSeeCount else {return}

        let checkedMovie = moviesToSeeArray.remove(at: index)
        moviesBeSawArray.append(checkedMovie)
    }
}
